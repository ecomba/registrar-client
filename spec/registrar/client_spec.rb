require 'spec_helper'

describe Registrar::Client do

  let(:provider) { stub("Provider") }

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

  describe "#parse" do
    it "returns an array of the name parts" do
      provider.expects(:parse).with(name).returns(['example','com'])
      client.parse(name).should eq(['example','com']) 
    end
  end

  describe "#available?" do
    it "returns true if a domain is available" do
      provider.expects(:available?).with(name).returns(true)
      client.available?(name).should be_true
    end
  end

  describe "#purchase" do
    let(:registrant) { Registrar::Contact.new }
    let(:order) { stub("Order") }

    it "requires a registrant" do
      lambda { client.purchase(name) }.should raise_error
      lambda { client.purchase(name, nil) }.should raise_error
    end
    context "with a successful registration" do
      it "returns an order upon success" do
        provider.expects(:purchase).with(name, registrant).returns(order)
        order = client.purchase(name, registrant)
        order.should_not be_nil
      end
    end
    
  end
end
