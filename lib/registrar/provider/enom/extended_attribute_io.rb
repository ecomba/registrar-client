module Registrar
  module Provider
    class Enom
      module ExtendedAttributeIO
        def io_names
          {
            :"Renewal Agreement" => 'io_agreedelete'
          }
        end
        def io_values
          {
            :"Yes" => 'YES'
          }
        end
      end
    end
  end
end
