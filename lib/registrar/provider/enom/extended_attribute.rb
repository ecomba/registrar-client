module Registrar
  module Provider
    class Enom
      # Wrapper around the generic extended attribute that resolves symbolic values
      # to their Enom-specific values.
      class ExtendedAttribute
        attr_reader :extended_attribute
        def initialize(extended_attribute)
          @extended_attribute = extended_attribute
        end

        def name
          resolve_name(extended_attribute.tld, extended_attribute.name)
        end
        def value
          resolve_value(extended_attribute.tld, extended_attribute.value)
        end

        private
        def resolve_name(tld, name)
          case name
          when Symbol then
            names(tld)[name]
          else
            name
          end
        end

        def names(tld)
          {
            'us' => us_names,
            'ca' => ca_names,
          }[tld]
        end

        def resolve_value(tld, value)
          case value
          when Symbol then
            values(tld)[value]
          else
            value
          end
        end

        def values(tld)
          {
            'us' => us_values,
            'ca' => ca_values,
          }[tld]
        end

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
