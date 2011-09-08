require 'nokogiri'

module Registrar
  module Provider
    class OpenSRS
      class Order

        def initialize(xml)
          @xml = Nokogiri::XML(xml) 
          @domains = []
        end
        
        def id
          @xml.xpath("//dt_assoc/item[@key='attributes']/dt_assoc/item[@key='id']").inner_text
        end
        
        def successful?
          element("is_success").inner_text == '1'
        end
        
        def complete?
          element("response_code").inner_text == '200'
        end
        
        def domains
          @domains
        end
        
        def add_domain(domain_name, registrant)
          @domains << create_domain(domain_name, registrant)
          self
        end

        def to_order
          order = Registrar::Order.new(id)
          order.successful= successful?
          order.status= complete? ? :closed : :open
          domains.each { |domain| order.domains<< domain }
          order
        end

        private
        def create_domain(domain_name, registrant)
          domain = Registrar::Domain.new(domain_name)
          domain.registrant = registrant
          domain.order = self
          domain
        end

        def element(element)
          @xml.xpath("//body/data_block/dt_assoc/item[@key='#{element}']")
        end
      end
    end
  end
end
