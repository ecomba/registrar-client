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
