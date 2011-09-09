module Registrar
  class PurchaseOptions
    attr_writer :number_of_years

    def has_name_servers?
      !name_servers.empty?
    end

    def name_servers
      @name_servers ||= []
    end

    def has_extended_attributes?
      !extended_attributes.empty?
    end

    def extended_attributes
      @extended_attributes ||= []
    end

    def number_of_years
      @number_of_years ||= 1
    end
  end
end
