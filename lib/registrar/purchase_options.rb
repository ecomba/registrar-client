module Registrar
  class PurchaseOptions
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

    attr_accessor :number_of_years
  end
end
