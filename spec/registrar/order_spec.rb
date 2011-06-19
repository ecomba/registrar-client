require 'spec_helper'

describe Registrar::Order do
  let(:order) { Registrar::Order.new }
  it "can be checked for completeness" do
    order.should be_complete
  end
end
