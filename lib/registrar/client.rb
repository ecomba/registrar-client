module Registrar
  class Client
    attr_reader :adapter

    def initialize(adapter)
      @adapter = adapter 
    end
  end
end
