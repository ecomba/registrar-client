require 'spec_helper'

describe Registrar::ExtendedAttribute do
  let(:attribute) { Registrar::ExtendedAttribute.new('us', :nexus, :personal) }

  it 'has the top level domain set' do
    attribute.tld.should eq 'us'
  end

  it 'has the name set' do
    attribute.name.should eq :nexus
  end

  it 'has the value set' do
    attribute.value.should eq :personal
  end
end
