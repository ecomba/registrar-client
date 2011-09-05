module Registrar
  module Provider
    class OpenSRS
      class Operation
        attr_reader :action, :object, :attributes
        def initialize(action, attributes)
          @action = action
          @object = :domain
          @attributes = attributes
        end
        def to_xml
          builder = Builder::XmlMarkup.new
          builder.OPS_envelope { |b| 
            b.header { |b| b.version('0.9') }
            b.body { |b| 
              b.data_block { |b|
                b.dt_assoc { |b|
                  b.item("XCP", :key => "protocol")
                  b.item(action.to_s.upcase, :key => "action")
                  b.item(object.to_s.upcase, :key => "object")
                  b.item(:key => "attributes") { |b|
                    b.dt_assoc { |b|
                      attributes.each do |key, value|
                        if (value.respond_to?(:to_xml))
                          b.item(:key => key.to_s) {
                            value.to_xml(b)
                          }
                        else
                          b.item(value.to_s, :key => key.to_s)
                        end
                      end
                    }
                  }
                }
              }
            }
          }
        end
      end
    end
  end
end
