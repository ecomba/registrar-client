require 'registrar/provider/enom/extended_attribute_us'
require 'registrar/provider/enom/extended_attribute_ca'
require 'registrar/provider/enom/extended_attribute_io'

module Registrar
  module Provider
    class Enom
      # Wrapper around the generic extended attribute that resolves symbolic values
      # to their Enom-specific values.
      class ExtendedAttribute
        include ExtendedAttributeUS
        include ExtendedAttributeCA
        include ExtendedAttributeIO
      
        attr_reader :extended_attribute
        def initialize(extended_attribute)
          @extended_attribute = extended_attribute
        end

        def name
          resolve_name(extended_attribute.tld, extended_attribute.name)
        end
        def value
          resolve_value(extended_attribute.tld, extended_attribute.value)
        end

        private
        def resolve_name(tld, name)
          case name
          when Symbol then
            names(tld)[name]
          else
            name
          end
        end

        def names(tld)
          {
            'us' => us_names,
            'ca' => ca_names,
            'io' => io_names,
          }[tld]
        end

        def resolve_value(tld, value)
          case value
          when Symbol then
            values(tld)[value]
          else
            value
          end
        end

        def values(tld)
          {
            'us' => us_values,
            'ca' => ca_values,
            'io' => io_values,
          }[tld]
        end
      end
    end
  end
end
