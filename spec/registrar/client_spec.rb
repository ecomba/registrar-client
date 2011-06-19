require 'spec_helper'

describe Registrar::Client do

  let(:provider) { stub("FakeProvider") }

  context "when instantiated" do
    it "requires a provider" do
      lambda { Registrar::Client.new }.should raise_error
    end
    it "instantiates without error" do
      lambda { Registrar::Client.new(provider) }.should_not raise_error
    end
  end
  
  let(:client) { Registrar::Client.new(provider) }
  let(:name) { "example.com" }
  
  describe "#check" do
    it "returns an array of the name parts" do
      provider.expects(:parse).with(name).returns(['example','com'])
      client.parse(name).should eq(['example','com']) 
    end
  end
end
