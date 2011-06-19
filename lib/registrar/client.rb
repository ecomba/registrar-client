module Registrar
  class Client
    attr_reader :adapter

    def initialize(adapter)
      @adapter = adapter 
    end

    def parse(name)
      adapter.parse(name)
    end
  end
end
