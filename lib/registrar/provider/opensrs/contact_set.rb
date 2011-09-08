module Registrar
  module Provider
    class OpenSRS
      class ContactSet
        attr_reader :contacts
        def initialize(contacts)
          @contacts = contacts
        end

        def to_xml(builder)
          builder.dt_assoc { |b|
            contacts.each do |key, contact|
              b.item(:key => key.to_s) { |b|
                b.dt_assoc { |b|
                  contact.to_xml(b)
                }
              }
            end
          }
        end
      end
    end
  end
end
