require 'spec_helper'
require 'registrar/provider/enom/extended_attribute'

describe Registrar::Provider::Enom::ExtendedAttribute do

  context "for a .ca extended attribute" do
    let(:extended_attribute) { Registrar::ExtendedAttribute.new('ca', :"Legal Type", :"Canadian Citizen") }
    let(:enom_extended_attribute) { Registrar::Provider::Enom::ExtendedAttribute.new(extended_attribute) }

    it "has a name" do
      enom_extended_attribute.name.should eq('cira_legal_type')
    end
    it "has a value" do
      enom_extended_attribute.value.should eq('CCT')
    end
  end

  context "for a .us extended attribute" do
    let(:extended_attribute) { Registrar::ExtendedAttribute.new('us', :"Nexus", :"US Citizen") }
    let(:enom_extended_attribute) { Registrar::Provider::Enom::ExtendedAttribute.new(extended_attribute) }

    it "has a name" do
      enom_extended_attribute.name.should eq('us_nexus')
    end
    it "has a value" do
      enom_extended_attribute.value.should eq('C11')
    end
  end
end
