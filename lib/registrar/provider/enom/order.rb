module Registrar
  module Provider
    class Enom
      # An Enom order.
      class Order
        attr_accessor :id
        attr_accessor :order_status
        attr_accessor :order_date
        attr_accessor :status

        def initialize(id)
          @id = id
        end

        def status
          @status || 'unknown'
        end

        def order_status
          @order_status || 'unknown'
        end

        # Get a generic Registrar::Order object to use.
        def to_order
          order = Registrar::Order.new(id)
          order.successful = status.downcase == "successful"
          
          order.status = case order_status.downcase
          when 'open' then :open 
          when 'closed' then :closed
          else
            order_status.downcase.to_sym
          end

          order.date = order_date 
          order
        end
      end
    end
  end
end
