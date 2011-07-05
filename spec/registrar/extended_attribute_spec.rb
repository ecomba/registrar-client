require 'spec_helper'

describe Registrar::ExtendedAttribute do
  it "is constructed with a tld, name and value" do
    extended_attribute = Registrar::ExtendedAttribute.new('us', :nexus, :personal) 
    extended_attribute.tld.should eq('us')
  end
end
