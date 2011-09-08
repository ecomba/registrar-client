require 'spec_helper'
require 'registrar/provider/enom/extended_attribute'

describe Registrar::Provider::Enom::ExtendedAttribute do

  let(:enom_extended_attribute) { Registrar::Provider::Enom::ExtendedAttribute.new(extended_attribute) }

  shared_examples "an extended attribute" do
    it "has a name" do
      enom_extended_attribute.name.should eq name
    end
    it "has a value" do
      enom_extended_attribute.value.should eq value
    end
  end

  context "for a .ca extended attribute" do
    let(:extended_attribute) { Registrar::ExtendedAttribute.new('ca', :"Legal Type", :"Canadian Citizen") }
    let(:name) { 'cira_legal_type' }
    let(:value) { 'CCT' }
    it_behaves_like "an extended attribute"
  end

  context "for a .us extended attribute" do
    let(:extended_attribute) { Registrar::ExtendedAttribute.new('us', :"Nexus", :"US Citizen") }
    let(:name)  { 'us_nexus' }
    let(:value) { 'C11' }
    it_behaves_like "an extended attribute"
  end
  
  context "for a .IO extended attribute" do
    let(:extended_attribute) { Registrar::ExtendedAttribute.new('io', :"Renewal Agreement", :"Yes") } 
    let(:name) { 'io_agreedelete' }
    let(:value) { 'YES' }
    it_behaves_like "an extended attribute"
  end
end
