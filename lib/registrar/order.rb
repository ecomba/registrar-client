module Registrar #:nodoc:
  # Instances of this class contain details about the current state of a
  # particular order with the registrar.
  class Order
    # The service-specific identifier for the order.
    attr_reader :identifier

    # Construct a new Order instance.
    def initialize(identifier)
      @identifier = identifier
    end

    # Get the domains associated with this order
    def domains
      @domains ||= []
    end

    # Return true if the order is complete.
    def complete?
      true 
    end
  end
end
