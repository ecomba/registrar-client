module Registrar
  module Provider
    # :nodoc:
    class Enom
      # Contact object that wraps a generic contact and can be used to produce and parse
      # wire-level representations of Enom contacts.
      class Contact
        attr_reader :contact

        def initialize(contact)
          raise ArgumentError, "Contact is required" unless contact
          @contact = contact
        end

        def identifier
          contact.identifier
        end

        def identifier=(identifier)
          contact.identifier = identifier
        end

        # Returns a Hash that can be merged into a query.
        # Type should be one of the following: Registrant, AuxBilling, Tech, Admin
        def to_query(type)
          {
            "#{type}Address1" => contact.address_1,
            "#{type}Address2" => contact.address_2,
            "#{type}City" => contact.city,
            "#{type}Country" => contact.country,
            "#{type}EmailAddress" => contact.email,
            "#{type}Fax" => contact.fax,
            "#{type}FirstName" => contact.first_name,
            "#{type}LastName" => contact.last_name,
            "#{type}JobTitle" => contact.job_title,
            "#{type}OrganizationName" => contact.organization_name,
            "#{type}Phone" => contact.phone,
            "#{type}PhoneExt" => contact.phone_ext,
            "#{type}PostalCode" => contact.postal_code,
            "#{type}StateProvince" => contact.state_province,
            "#{type}StateProvinceChoice" => contact.state_province_choice
          }
        end
      end
    end
  end
end
