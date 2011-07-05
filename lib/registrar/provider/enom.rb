require 'registrar/provider/enom/contact'
require 'registrar/provider/enom/extended_attribute'

module Registrar
  module Provider
    # Implementation of a registrar provider for Enom (http://www.enom.com/).
    class Enom
      include HTTParty

      attr_accessor :url, :username, :password

      def initialize(url, username, password)
        @url = url
        @username = username
        @password = password
      end

      def parse(name)
        query = base_query.merge('Command' => 'ParseDomain')
        response = execute(query.merge('PassedDomain' => name))
        
        [response['ParseDomain']['SLD'], response['ParseDomain']['TLD']] 
      end

      def available?(name)
        sld, tld = parse(name)
        
        query = base_query.merge('Command' => 'Check')
        response = execute(query.merge('SLD' => sld, 'TLD' => tld))
        
        response['RRPCode'] == '210'
      end

      def purchase(name, registrant, purchase_options=nil)
        purchase_options ||= Registrar::PurchaseOptions.new

        sld, tld = parse(name)
        query = base_query.merge('Command' => 'Purchase', 'SLD' => sld, 'TLD' => tld)
        registrant = Enom::Contact.new(registrant)
             
        if registrant
          query.merge!(registrant.to_enom("Registrant"))
          query.merge!(registrant.to_enom("AuxBilling"))
          query.merge!(registrant.to_enom("Tech"))
          query.merge!(registrant.to_enom("Admin"))
        end

        if purchase_options.has_name_servers? 
          query['IgnoreNSFail'] = 'Yes'
          purchase_options.name_servers.each_with_index do |name_server, i|
            query["NS#{i+1}"] = name_server.name
          end
        else
          query['UseDNS'] = 'default'
        end

        if purchase_options.has_extended_attributes?
          extended_attributes = purchase_options.extended_attributes.map { |a| Enom::ExtendedAttribute.new(a) }
          extended_attributes.each do |extended_attribute| 
            query[extended_attribute.name] = extended_attribute.value
          end
        end

        query['NumYears'] = purchase_options.number_of_years || minimum_number_of_years(tld)
         
        response = execute(query)

        order = Registrar::Order.new(response['OrderID'])

        registrant.identifier = response['RegistrantPartyID']

        domain = Registrar::Domain.new(name) 
        domain.registrant = registrant
        domain.order = order 
        order.domains << domain

        order
      end

      private
      def execute(query)
        Encoding.default_internal = Encoding.default_external = "UTF-8"
        options = {:query => query, :parser => EnomParser}
        response = self.class.get(url, options)['interface_response']
        raise EnomError.new(response) if response['ErrCount'] != '0'
        response
      end

      def base_query
        {
          'UID' => username,
          'PW' => password,
          'ResponseType' => 'XML'
        }
      end

      def minimum_number_of_years(tld)
        {
          'co.uk' => 2,
          'org.uk' => 2,
          'nu' => 2,
          'tm' => 10,
          'com.mx' => 2,
          'me.uk' => 2
        }[tld] || 1
      end
      
    end

    class EnomError < RuntimeError
      attr_reader :response
      attr_reader :errors

      def initialize(response)
        @response = response
        @errors = []

        response['errors'].each do |k, err|
          @errors << err
        end

        super response['errors'].values.join(", ")
      end
    end

    class EnomParser < HTTParty::Parser
      def body 
        @body.force_encoding('UTF-8')
      end
    end
  end
end
