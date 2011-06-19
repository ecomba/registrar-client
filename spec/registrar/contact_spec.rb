require 'spec_helper'

describe Registrar::Contact do
  it "can be instantiated" do
    contact = Registrar::Contact.new
    contact.should_not be_nil
  end
  it "can be instantiated with attributes" do
    attributes = {:first_name => 'John'}
    contact = Registrar::Contact.new(attributes)
    contact.first_name.should eq(attributes[:first_name])
  end
  it "ignores attributes that do not exist" do
    attributes = {:foo => 'John'}
    contact = Registrar::Contact.new(attributes)
  end
end
