module Registrar
  module Provider
    class Enom
      include HTTParty

      attr_accessor :url, :username, :password

      def initialize(url, username, password)
        @url = url
        @username = username
        @password = password
      end

      def execute(query)
        Encoding.default_internal = Encoding.default_external = "UTF-8"
        response = self.class.get(
          url, 
          :query => query, 
          :parser => EnomParser
        )['interface_response']

        if response['ErrCount'] != '0'
          raise EnomError.new(response)
        end  
        response
      end
      private :execute

      def base_query
        {
          'UID' => username,
          'PW' => password,
          'ResponseType' => 'XML'
        }
      end

      def parse(name)
        response = execute(base_query.merge(
          'Command' => 'ParseDomain', 
          'PassedDomain' => name
        ))
        [response['ParseDomain']['SLD'], response['ParseDomain']['TLD']] 
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
