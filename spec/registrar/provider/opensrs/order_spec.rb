require 'spec_helper'
require 'registrar/provider/opensrs/order'

describe Registrar::Provider::OpenSRS::Order do
  XML = <<EOX
<?xml version='1.0' encoding="UTF-8" standalone="no" ?>
<!DOCTYPE OPS_envelope SYSTEM "ops.dtd">
<OPS_envelope>
  <header>
    <version>0.9</version>
  </header>
  <body>
    <data_block>
      <dt_assoc>
        <item key="protocol">XCP</item>
        <item key="object">DOMAIN</item>
        <item key="response_text">Registration successful</item>
        <item key="action">REPLY</item>
        <item key="attributes"> 
          <dt_assoc>
            <item key="admin_email">anthony@dnsimple.com</item>
            <item key="id">2053299</item>
          </dt_assoc>
        </item>
        <item key="response_code">200</item>
        <item key="is_success">1</item>
      </dt_assoc>
    </data_block>
  </body>
</OPS_envelope>
EOX

  let(:order)      { Registrar::Provider::OpenSRS::Order.new XML }
  let(:name)       { 'mydomain.com' }
  let(:registrant) { :registrant }

  context 'creation' do
    it 'is a successful order' do
      order.should be_successful
    end

    it 'the order is completed' do
      order.should be_complete
    end

    it 'has an id' do
      order.id.should == '2053299'
    end
  end

  context 'adds a domain to the order' do
    before do
      order.add_domain name, registrant
    end

    it 'keeps the name of the added domain' do
      order.domains.first.name.should == name
    end

    it 'and the domain has the registrant' do
      order.domains.first.registrant.should be registrant
    end

    it 'and the domain has the order in it' do
      order.domains.first.order.should be order
    end
  end

  context 'transformantion' do
    before do
      order.add_domain name, registrant
      @registrar_order = order.to_order
    end
    it 'has the domains' do
      @registrar_order.domains.first.name.should == order.domains.first.name
    end
  end
end
