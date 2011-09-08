require 'spec_helper'
require 'registrar/provider/enom/order'

describe Registrar::Provider::Enom::Order do
  let(:id) { '12345' }
  let(:enom_order) { Registrar::Provider::Enom::Order.new(id) }
  let(:order) { enom_order.to_order }
  
  before do
    enom_order.order_date = '2011-01-01 14:55:34'
  end

  it "can be converted to a generic order object" do
    order.should_not be_nil
  end
  it "has the order date" do
    order.date.should eq(enom_order.order_date)
  end

  it "has a status of 'unknown' by default" do
    enom_order.status.should eq('unknown')
  end
  it "has an order status of 'unknown' by default" do
    enom_order.order_status.should eq('unknown')
  end

  context "a successful order" do
    before do
      enom_order.status = 'successful'
      enom_order.order_status = 'closed'
    end
    
    it "indicates that it is successful" do
      order.should be_successful
    end
    it "has the status of :closed" do
      order.status.should eq(:closed)
    end
  end

  context "an open order" do
    before do
      enom_order.order_status = 'open'
    end
    it "has the status of :open" do
      order.status.should eq(:open)
    end
  end
end
