require 'spec_helper'
require 'registrar/provider/opensrs/contact'

describe Registrar::Provider::OpenSRS::Contact do

  it "requires a contact" do
    lambda { Registrar::Provider::OpenSRS::Contact.new(nil) }.should raise_error(ArgumentError)
  end

  context "with a contact" do
    let(:contact) { Registrar::Contact.new(
      :identifier => '12345',
      :first_name => 'John',
      :last_name => 'Doe',
      :address_1 => '1 SW 1st Street',
      :address_2 => 'Apt 305',
      :city => 'Miami',
      :state_province => 'Florida',
      :country => 'US',
      :postal_code => '33143',
      :phone => '321 213 3656',
      :email => 'john.doe@example.com'
    )}

    it "produces xml" do
      builder = Builder::XmlMarkup.new
      opensrs_contact = Registrar::Provider::OpenSRS::Contact.new(contact)
      opensrs_contact.to_xml(builder).should eq("<item key=\"first_name\">John</item><item key=\"last_name\">Doe</item><item key=\"phone\">321 213 3656</item><item key=\"fax\"></item><item key=\"email\">john.doe@example.com</item><item key=\"org_name\"></item><item key=\"address1\">1 SW 1st Street</item><item key=\"address2\">Apt 305</item><item key=\"city\">Miami</item><item key=\"state\">Florida</item><item key=\"country\">US</item><item key=\"postal_code\">33143</item>")
    end
  end
end
