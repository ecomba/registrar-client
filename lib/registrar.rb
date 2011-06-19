require 'httparty'

require 'registrar/client'

module Registrar
  # Error indicating that a registrar provider is required but none was 
  # available.
  class ProviderRequiredError < RuntimeError
  end
end
