module Registrar
  module Provider
    # :nodoc:
    class OpenSRS
      class Contact
        attr_reader :contact

        def initialize(contact)
          raise ArgumentError, "Contact is required" unless contact
          @contact = contact
        end

        def to_xml(builder)
          builder.item(contact.first_name, :key => "first_name")
          builder.item(contact.last_name, :key => "last_name")
          builder.item(contact.phone, :key => "phone")
          builder.item(contact.fax, :key => "fax")
          builder.item(contact.email, :key => "email")
          builder.item(contact.organization_name, :key => "org_name")
          builder.item(contact.address_1, :key => "address1")
          builder.item(contact.address_2, :key => "address2")
          builder.item(contact.city, :key => "city")
          builder.item(contact.state_province, :key => "state")
          builder.item(contact.country, :key => "country")
          builder.item(contact.postal_code, :key => "postal_code")
        end
      end
    end
  end
end
