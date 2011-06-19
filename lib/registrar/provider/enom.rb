module Registrar
  module Provider
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

    class Enom
      include HTTParty

      def initialize(url, username, password)
        @url = url
        @username = username
        @password = password
      end

      def url
        @url
      end
      private :url

      def username
        @username
      end
      private :username

      def password
        @password
      end
      private :password


      def execute(query)
        Encoding.default_internal = Encoding.default_external = "UTF-8"
        response = self.class.get(url, :query => query, :parser => EnomParser)['interface_response']

        if response['ErrCount'] != '0'
          raise EnomError.new(response)
        end  
        response
      end
      private :execute

      def parse(name)
        base_query = {
          'UID' => username,
          'PW' => password,
          'ResponseType' => 'XML'
        }
        query = base_query.merge('Command' => 'ParseDomain', 'PassedDomain' => name)
        response = execute(query)

        if response['ErrCount'].to_i > 0
          raise EnomError, response
        else
          [response['ParseDomain']['SLD'], response['ParseDomain']['TLD']]
        end 
      end
    end
  end
end
