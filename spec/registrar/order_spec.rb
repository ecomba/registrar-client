require 'spec_helper'

describe Registrar::Order do
  let(:order_identifier) { "X-1212" }
  let(:order) { Registrar::Order.new(order_identifier) }

  it "is not complete by default" do
    order.should_not be_complete
  end

  it "has domains" do
    order.domains.should be_empty
  end

  it "has a status" do
    order.status.should eq(:unknown)
  end

  it "is complete when the status is not open and not unknown" do
    order.status = :closed
    order.should be_complete
  end

  it "is successful when marked as such" do
    order.should_not be_successful
    order.successful = true
    order.should be_successful
  end

end
