require 'spec_helper'

require 'registrar/provider/opensrs'

describe "registrar client integration with opensrs" do
  let(:config) { YAML.load_file('spec-integration/opensrs.yml') }
  let(:url) { config['url'] }
  let(:username) { config['username'] }
  let(:private_key) { config['private_key'] }

  let(:provider) { Registrar::Provider::OpenSRS.new(url, username, private_key) }
  let(:client) { Registrar::Client.new(provider) }

  let(:name) { "example.com" }

  let(:registrant) do
    Registrar::Contact.new({
      :first_name => 'Anthony',
      :last_name => 'Eden',
      :organization_name => 'NA',
      :address_1 => '123 SW 1st Street',
      :city => 'Anywhere',
      :state_province => 'CA',
      :country => 'US',
      :postal_code => '12121',
      :phone => '444 555 1212',
      :email => 'anthony@dnsimple.com'
    })
  end

  describe "#available?" do
    context "for an available domain" do
      it "returns true" do
        client.available?("1283475853rwjg.com").should be_true
      end
    end
    context "for an unavailable domain" do
      it "returns false" do
        client.available?("google.com").should be_false
      end
    end
  end

  shared_examples "a real-time domain without extended attributes" do
    describe "#purchase" do
      let(:order) { client.purchase(name, registrant) }
      it "returns a completed order" do
        order.should be_complete
      end
    end
  end

  describe "#purchase" do
    context "for an available .com" do
      it_behaves_like "a real-time domain without extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.com" }
      end
    end
  end
end
