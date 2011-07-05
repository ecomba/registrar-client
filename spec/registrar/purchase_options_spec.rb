require 'spec_helper'

describe Registrar::PurchaseOptions do
  context "by default" do
    subject { Registrar::PurchaseOptions.new }
    it "does not specify name servers" do
      subject.has_name_servers?.should be_false
    end
    it "does not specify extended attributes" do
      subject.has_extended_attributes?.should be_false
    end
    it "returns nil for number of years" do
      subject.number_of_years.should be_nil
    end
  end
end
