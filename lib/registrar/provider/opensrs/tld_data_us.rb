module Registrar
  module Provider
    class OpenSRS
      class TldDataUs

        attr_reader :category
        attr_reader :app_purpose

        DEFINITIONS = {
          :"US Citizen" => 'C11',
          :"Business Entity" => 'C21',
          :"Foreign Entity" => 'C31',
          :"Permanent Resident" => 'C12',
          :"US Based Office" => 'C22',
          :"For Profit" => 'P1',
          :"Non Profit" => 'P2',
          :Personal => 'P3',
          :Educational => 'P4',
          :Government => 'P5'
        }

        SELECT_OPTION = ->(options, name){
          options.select { |option| option.name == name }.first.value
        }

        def initialize options
          @category    = DEFINITIONS[SELECT_OPTION.call(options, :Nexus)]
          @app_purpose = DEFINITIONS[SELECT_OPTION.call(options, :Purpose)]
        end

        def to_xml(context)
          context.dt_assoc do |dt_assoc|
            dt_assoc.item(key: 'nexus') do |item|
              item.dt_assoc do |inner_dt_assoc|
                inner_dt_assoc.item(key: 'category') do |category|
                  category.text! @category
                end
                inner_dt_assoc.item(key: 'app_purpose') do
                  |purpose| purpose.text! @app_purpose
                end
              end
            end
          end
        end
      end
    end
  end
end
