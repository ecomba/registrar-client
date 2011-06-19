require 'spec_helper'

describe Registrar::Client do
  context "when instantiated" do
    it "requires a provider" do
      lambda { Registrar::Client.new(:missing) }.should raise_error(Registrar::AdapterNotFoundError)
    end
    it "loads the adapter" do
      lambda { Registrar::Client.new(:enom) }.should_not raise_error
    end
  end
end
