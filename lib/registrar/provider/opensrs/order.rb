require 'nokogiri'

module Registrar
  module Provider
    class OpenSRS
      class Order
        attr_accessor :id

        def initialize(xml)
          @xml = Nokogiri::XML(xml) 
        end
        
        def successful?
          element("is_success").inner_text == '1'
        end
        
        def complete?
          element("response_code").inner_text == '200'
        end

        def to_order
          order = Registrar::Order.new(id)
          order.successful= successful?
          order.status= complete?

          order
        end

        private

        def element(element)
          @xml.xpath("//body/data_block/dt_assoc/item[@key='#{element}']")
        end

      end
    end
  end
end
