module Registrar
  class Client
    def initialize(adapter_identifier)
      if adapter_identifier == :enom
        require 'registrar/adapter/enom'
        @adapter = Registrar::Adapter::Enom.new
      else
        raise AdapterNotFoundError 
      end
    end
  end
end
