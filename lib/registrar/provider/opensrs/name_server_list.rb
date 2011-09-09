module Registrar
  module Provider
    class OpenSRS
      class NameServerList 
        attr_reader :nameservers

        def initialize(purchase_options)
          @nameservers = purchase_options.name_servers
        end

        def to_xml(context)
          context.dt_array do |dt_array|
            @nameservers.each_with_index do |nameserver, index|
              dt_array.item(key: index) do |item|
                item.dt_assoc do |dt_assoc|
                  dt_assoc.item(key: 'sortorder') { |item| item.text! "#{index + 1}" }
                  dt_assoc.item(key: 'name') {|item| item.text! nameserver.name }
                end
              end
            end
          end
        end
      end
    end
  end
end
