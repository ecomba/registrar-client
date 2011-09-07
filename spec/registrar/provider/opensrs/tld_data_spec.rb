require 'spec_helper'
require 'registrar/provider/opensrs/tld_data'
require 'registrar/provider/opensrs/tld_data_us'

describe Registrar::Provider::OpenSRS::TldData do

  context 'special orders' do

    let(:tld_data) { Registrar::Provider::OpenSRS::TldData }

    it 'us tld data' do
      purchase_options = Registrar::PurchaseOptions.new
      purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('us', :Nexus, :"US Citizen")
      purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('us', :Purpose, :"Personal")
      purchase_options
      tld_data.build_with(purchase_options).class.should == Registrar::Provider::OpenSRS::TldDataUs
    end
  end

end
