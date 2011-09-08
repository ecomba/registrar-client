require 'spec_helper'
require 'nokogiri'
require 'registrar/provider/opensrs/order'

describe Registrar::Provider::OpenSRS::Order do
  let(:xml) { %q{
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
    <item key="response_text">Command completed successfully</item>
    <item key="action">REPLY</item>
    <item key="attributes">
     <dt_assoc>
      <item key="field_hash">
       <dt_assoc>
        <item key="owner_address2"></item>
        <item key="billing_address1">123 SW 1st Street</item>
        <item key="owner_address1">123 SW 1st Street</item>
        <item key="billing_org_name">NA</item>
        <item key="tech_last_name">Eden</item>
        <item key="processed_date"></item>
        <item key="billing_country">US</item>
        <item key="owner_address3"></item>
        <item key="billing_address2"></item>
        <item key="fqdn2">ns2.dnsimple.com</item>
        <item key="period">1</item>
        <item key="admin_address3"></item>
        <item key="billing_postal_code">12121</item>
        <item key="admin_postal_code">12121</item>
        <item key="owner_org_name">NA</item>
        <item key="owner_fax"></item>
        <item key="tech_address3"></item>
        <item key="encoding_type"></item>
        <item key="admin_org_name">NA</item>
        <item key="tech_org_name">NA</item>
        <item key="tech_postal_code">12121</item>
        <item key="nexus_category">Natural Person -- U.S. Citizen</item>
        <item key="tech_email">anthony@dnsimple.com</item>
        <item key="billing_phone">+1.4445551212</item>
        <item key="affiliate_id"></item>
        <item key="tech_fax"></item>
        <item key="owner_state">CA</item>
        <item key="owner_email">anthony@dnsimple.com</item>
        <item key="billing_first_name">Anthony</item>
        <item key="fqdn4">ns4.dnsimple.com</item>
        <item key="domain">test-1315475733-9453.us</item>
        <item key="billing_address3"></item>
        <item key="admin_fax"></item>
        <item key="app_purpose">Personal Use</item>
        <item key="flag_saved_tech_fields">1</item>
        <item key="billing_state">CA</item>
        <item key="completed_date">1315475738</item>
        <item key="billing_city">Anywhere</item>
        <item key="notes">
         <dt_array>
         </dt_array>
        </item>
        <item key="reg_domain"></item>
        <item key="fqdn3">ns3.dnsimple.com</item>
        <item key="fqdn5"></item>
        <item key="nexus_validator">Not Applicable</item>
        <item key="tech_city">Anywhere</item>
        <item key="owner_phone">+1.4445551212</item>
        <item key="comments"></item>
        <item key="admin_state">CA</item>
        <item key="owner_postal_code">12121</item>
        <item key="id">2056895</item>
        <item key="admin_first_name">Anthony</item>
        <item key="admin_phone">+1.4445551212</item>
        <item key="tech_state">CA</item>
        <item key="cost">10</item>
        <item key="billing_last_name">Eden</item>
        <item key="owner_city">Anywhere</item>
        <item key="flag_saved_ns_fields">1</item>
        <item key="admin_last_name">Eden</item>
        <item key="tech_phone">+1.4445551212</item>
        <item key="master_order_id">0</item>
        <item key="tech_address2"></item>
        <item key="order_date">1315475734</item>
        <item key="admin_address1">123 SW 1st Street</item>
        <item key="tech_address1">123 SW 1st Street</item>
        <item key="f_auto_renew">N</item>
        <item key="owner_last_name">Eden</item>
        <item key="forwarding_email"></item>
        <item key="billing_fax"></item>
        <item key="billing_email">anthony@dnsimple.com</item>
        <item key="status">completed</item>
        <item key="fqdn6"></item>
        <item key="admin_country">US</item>
        <item key="admin_email">anthony@dnsimple.com</item>
        <item key="reg_type">new</item>
        <item key="owner_country">US</item>
        <item key="admin_city">Anywhere</item>
        <item key="fqdn1">ns1.dnsimple.com</item>
        <item key="tech_country">US</item>
        <item key="tech_first_name">Anthony</item>
        <item key="f_lock_domain">0</item>
        <item key="f_bypass_confirm"></item>
        <item key="owner_first_name">Anthony</item>
        <item key="admin_address2"></item>
       </dt_assoc>
      </item>
     </dt_assoc>
    </item>
    <item key="response_code">200</item>
    <item key="is_success">1</item>
   </dt_assoc>
  </data_block>
 </body>
</OPS_envelope>
  }}

  let(:order)      { Registrar::Provider::OpenSRS::Order.new xml }
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
      order.id.should == '2056895'
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
