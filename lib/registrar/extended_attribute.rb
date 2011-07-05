module Registrar
  class ExtendedAttribute
    attr_accessor :tld
    attr_accessor :name
    attr_accessor :value
    def initialize(tld, name, value)
      @tld = tld
      @name = name
      @value = value 
    end
  end
end
