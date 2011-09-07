require 'registrar/provider/opensrs/tld_data_us'

module Registrar
  module Provider
    class OpenSRS
      class TldData
        def self.build_with(purchase_options)
          build_us_tld_data(purchase_options.extended_attributes.select do |attribute|
            attribute.tld == 'us'
          end)
        end

        private
        def self.build_us_tld_data(options)
          TldDataUs.new(options)
        end
      end
    end
  end
end
