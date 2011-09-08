require 'spec_helper'
require 'registrar/provider/enom/contact'

describe Registrar::Provider::Enom::Contact do
  it "requires a generic contact object" do
    lambda { Registrar::Provider::Enom::Contact.new(nil) }.should raise_error(ArgumentError)
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
    let(:enom_contact) { Registrar::Provider::Enom::Contact.new(contact) }
    it "has an identifier" do
      enom_contact.identifier.should eq(contact.identifier)
    end
    it "can be converted to a query" do
      query_hash = enom_contact.to_query("Registrant")
      query_hash["RegistrantAddress1"].should eq(contact.address_1)
      query_hash["RegistrantAddress2"].should eq(contact.address_2)
      query_hash["RegistrantCity"].should eq(contact.city)
      query_hash["RegistrantCountry"].should eq(contact.country)
      query_hash["RegistrantEmailAddress"].should eq(contact.email)
      query_hash["RegistrantFax"].should eq(contact.fax)
      query_hash["RegistrantFirstName"].should eq(contact.first_name)
      query_hash["RegistrantLastName"].should eq(contact.last_name)
      query_hash["RegistrantJobTitle"].should eq(contact.job_title)
      query_hash["RegistrantOrganizationName"].should eq(contact.organization_name)
      query_hash["RegistrantPhone"].should eq(contact.phone)
      query_hash["RegistrantPhoneExt"].should eq(contact.phone_ext)
      query_hash["RegistrantPostalCode"].should eq(contact.postal_code)
      query_hash["RegistrantStateProvince"].should eq(contact.state_province)
      query_hash["RegistrantStateProvinceChoice"].should eq(contact.state_province_choice)
    end
  end
end
