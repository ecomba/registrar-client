module Registrar
  class Contact
    attr_accessor :identifier
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :address_1
    attr_accessor :address_2
    attr_accessor :city
    attr_accessor :state_province
    attr_accessor :state_province_choice
    attr_accessor :country
    attr_accessor :postal_code
    attr_accessor :phone
    attr_accessor :phone_ext
    attr_accessor :fax
    attr_accessor :email
    attr_accessor :organization_name
    attr_accessor :job_title
    
    # Create a new contact optionally providing a Hash with name/value pairs
    # representing one or more of the contact attributes.
    def initialize(attributes={})
      attributes.each do |k, v|
        m = "#{k}="
        if respond_to?(m)
          send(m, v)
        end
      end
    end
  end
end
