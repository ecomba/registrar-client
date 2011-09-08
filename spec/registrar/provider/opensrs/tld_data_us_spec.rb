require 'spec_helper'
require 'builder'
require 'registrar/provider/opensrs/tld_data_us'

describe Registrar::Provider::OpenSRS::TldDataUs do
  context 'creating a valid tld data' do
    let(:options) do
      [Registrar::ExtendedAttribute.new('us', :Nexus, :"US Citizen"),
        Registrar::ExtendedAttribute.new('us', :Purpose, :"For Profit")]
    end

    let(:tld_data) { Registrar::Provider::OpenSRS::TldDataUs.new(options) }

    it 'has a category' do
      tld_data.category.should eq 'C11'
    end

    it 'has a purpose' do
      tld_data.app_purpose.should eq 'P1'
    end

    context 'xml generation' do
      XML = %q{<dt_assoc><item key="nexus"><dt_assoc><item key="category">C11</item><item key="app_purpose">P1</item></dt_assoc></item></dt_assoc>}

      it 'generates the us tld xml part' do
        tld_data.to_xml(Builder::XmlMarkup.new).should eq XML
      end
    end
  end
  context 'creating an invalid one' do
    let(:options) do
      [Registrar::ExtendedAttribute.new('us', :Nexus, :"US Citizen")]
    end

    let(:tld_data) { Registrar::Provider::OpenSRS::TldDataUs.new(options) }

    it 'does something' do
      tld_data.app_purpose
    end
  end
end
