require 'digest/md5'
require 'builder'
require 'nokogiri'
require 'registrar/provider/opensrs/order'
require 'registrar/provider/opensrs/operation'
require 'registrar/provider/opensrs/contact'
require 'registrar/provider/opensrs/contact_set'

module Registrar
  module Provider
    # Implementation of a registrar provider for OpenSRS (http://www.opensrs.com/).
    class OpenSRS
      include HTTParty
      format :xml
      debug_output $stderr

      attr_accessor :url, :username, :private_key

      def initialize(url, username, private_key)
        @url = url
        @username = username
        @private_key = private_key
      end

      def available?(name)
        operation = Operation.new(:lookup, {
          :domain => name, 
          :no_cache => "1",
        })

        response = execute(operation.to_xml)

        items = response['OPS_envelope']['body']['data_block']['dt_assoc']['item']
        items = items.find { |item| item['dt_assoc'] }['dt_assoc']
        items['item'][0] == 'available'
      end

      def purchase(name, registrant, purchase_options=nil)

        response = execute(operation(name, registrant, purchase_options).to_xml)

        order = order(response.body)
        pp order.inspect
        order.add_domain(name, registrant)
        order.to_order
      end

      def order(raw_xml)
        id = Nokogiri::XML(raw_xml).xpath("//dt_assoc/item[@key='attributes']/dt_assoc/item[@key='id']").inner_text
        operation = Operation.new(:get_order_info, {
          :order_id => id})
        Registrar::Provider::OpenSRS::Order.new(execute(operation.to_xml).to_s)
      end

      private

      def operation(name, registrant, purchase_options)
        operation = Operation.new(:sw_register, {
          :domain => name,
          :period => "1",
          :reg_type => "new",
          :handle => 'process',
          :reg_username => 'dnsimple',
          :reg_password => 'password',
          :custom_tech_contact => '1',
          :contact_set => contact_set(registrant),
          :tld_data => tld_data(purchase_options)
        })
      end

      def tld_data(purchase_options)
        TldData.build_with(purchase_options) if purchase_options
      end

      def contact_set(registrant)
        ContactSet.new({
          'owner' => OpenSRS::Contact.new(registrant),
          'admin' => OpenSRS::Contact.new(registrant),
          'billing' => OpenSRS::Contact.new(registrant),
          'tech' => OpenSRS::Contact.new(registrant)
        })
      end

      def execute(body)
        self.class.headers(
          "Content-Type" => "text/xml",
          "X-Username" => username,
          "X-Signature" => signature(body),
          "Content-Length" => body.length.to_s
        )
        self.class.post(url, {:body => body})
      end

      def signature(body)
        step1 = Digest::MD5.hexdigest("#{body}#{private_key}")
        Digest::MD5.hexdigest("#{step1}#{private_key}")
      end
    end
  end
end
