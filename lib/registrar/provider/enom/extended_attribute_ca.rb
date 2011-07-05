module Registrar
  module Provider
    class Enom
      module ExtendedAttributeCA
        protected
        def ca_names
          {
            :"Legal Type" => 'cira_legal_type',
            :"Agreement Version" => 'cira_agreement_version',
            :"Agreement Value" => 'cira_agreement_value',
          }
        end
        def ca_values
          {
            :"Aboriginal Peoples" => "ABO",
            :"Canadian Citizen" => "CCT",
            :"Canadian Resident" => "RES",
            :"Corporation" => "CCO",
            :"Educational" => "EDU",
            :"Government Entity" => "GOV",
            :"Hospital" => "HOP",
            :"Indian Band" => "INB",
            :"Legal Representative" => "LGR",
            :"Library, Archive or Museum" => "LAM",
            :"Official Mark" => "OMK",
            :"Partnership" => "PRT",
            :"Political Party" => "PLT",
            :"The Queen" => "MAJ",
            :"Trade Union" => "TRD",
            :"Trade-mark" => "TDM",
            :"Trust" => "TRS",
            :"Unincorporated Association" => "ASS",
            :"Yes" => "Y",
            :"No" => "N",
          }
        end
      end
    end
  end
end
