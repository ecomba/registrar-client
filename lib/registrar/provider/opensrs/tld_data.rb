require 'registrar/provider/opensrs/tld_data_us'

module Registrar
  module Provider
    class OpenSRS
      class TldData
        TLDS = {
          ['us'] => ->(options)do
            us_options = options.extended_attributes.select do |attribute|
              attribute.tld == 'us'
            end
            TldDataUs.new(us_options)
          end
        }

        class << self
          def build_with(options)
            TLDS[tld(options)].call(options)
          end

          private
          def tld(options)
            options.extended_attributes.inject([]) { |a, b| a<< b.tld}.uniq
          end
        end
      end
    end
  end
end
