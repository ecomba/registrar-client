module Registrar
  module Provider
    class Enom
      module ExtendedAttributeUS
        def us_names
          {
            :Nexus => 'us_nexus',
            :Purpose => 'us_purpose',
            :Country => 'global_cc_us'
          }
        end
        def us_values
          {
            :"US Citizen" => 'C11',
            :"Business Entity" => 'C21',
            :"Foreign Entity" => 'C31',
            :"Permanent Resident" => 'C12',
            :"US Based Office" => 'C22',
            :"For Profit" => 'P1',
            :"Non Profit" => 'P2',
            :Personal => 'P3',
            :Educational => 'P4',
            :Government => 'P5',
          }
        end
      end
    end
  end
end
