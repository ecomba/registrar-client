module Registrar
  module Provider
    class OpenSRS
      class Order
        attr_accessor :id

        def initialize(id)
          @id = id
        end
        
        def to_order
          order = Registrar::Order.new(id)

          order
        end
      end
    end
  end
end
