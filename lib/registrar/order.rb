module Registrar #:nodoc:
  # Instances of this class contain details about the current state of a
  # particular order with the registrar.
  class Order
    # Return true if the order is complete.
    def complete?
      true 
    end
  end
end
