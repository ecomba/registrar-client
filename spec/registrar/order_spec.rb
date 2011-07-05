require 'spec_helper'

describe Registrar::Order do
  let(:order_identifier) { "X-1212" }
  let(:order) { Registrar::Order.new(order_identifier) }

  it "can be checked for completeness" do
    order.should be_complete
  end

  it "has domains" do
    order.domains.should be_empty
  end
end
