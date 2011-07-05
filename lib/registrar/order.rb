module Registrar #:nodoc:
  # Instances of this class contain details about the current state of a
  # particular order with the registrar.
  class Order
    # The service-specific identifier for the order.
    attr_reader :identifier

    # The current status of the order
    attr_accessor :status

    # The date the order was created
    attr_accessor :date

    # Construct a new Order instance.
    def initialize(identifier)
      @identifier = identifier
      @status = :unknown
      @successful = false
    end

    # Get the domains associated with this order
    def domains
      @domains ||= []
    end

    # Return true if the order is complete.
    def complete?
      ![:open, :unknown].include?(@status) 
    end

    def successful?
      @successful
    end

    def successful=(successful)
      @successful = successful
    end
  end
end
