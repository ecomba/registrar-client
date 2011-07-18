require 'digest/md5'
require 'builder'

module Registrar
  module Provider
    # Implementation of a registrar provider for OpenSRS (http://www.opensrs.com/).
    class OpenSRS
      include HTTParty
      format :xml

      attr_accessor :url, :username, :private_key

      def initialize(url, username, private_key)
        @url = url
        @username = username
        @private_key = private_key
      end

      def available?(name)
        builder = Builder::XmlMarkup.new
        body = builder.OPS_envelope { |b| 
          b.header { |b| b.version('0.9') }
          b.body { |b| 
            b.data_block { |b|
              b.dt_assoc { |b|
                b.item("XCP", :key => "protocol")
                b.item("LOOKUP", :key => "action")
                b.item("DOMAIN", :key => "object")
                b.item(:key => "attributes") { |b|
                  b.dt_assoc { |b|
                    b.item(name, :key => "domain")
                    b.item("1", :key => "no_cache")
                  }
                }
              }
            }
          }
        }

        execute(body)
      end

      private
      def execute(body)
        self.class.headers(
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
