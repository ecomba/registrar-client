require 'spec_helper'

describe Registrar::Client do

  context "when instantiated" do
    it "requires a provider" do
      lambda { Registrar::Client.new }.should raise_error
    end
    it "instantiates without error" do
      require 'registrar/provider/enom'
      lambda { Registrar::Client.new(Registrar::Provider::Enom.new) }.should_not raise_error
    end
  end

  let(:client) { Registrar::Client.new }
  
  describe "#check" do
    it "returns an array of the name parts" do
      
    end
  end
end
