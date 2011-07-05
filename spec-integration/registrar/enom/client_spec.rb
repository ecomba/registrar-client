require 'spec_helper'

require 'registrar/provider/enom'

describe "registrar client integration with enom" do
  let(:config) { YAML.load_file('spec-integration/enom.yml') }
  let(:url) { config['url'] }
  let(:username) { config['username'] }
  let(:password) { config['password'] }

  let(:provider) { Registrar::Provider::Enom.new(url, username, password) }
  let(:client) { Registrar::Client.new(provider) }

  let(:name) { "example.com" }

  describe "#parse" do
    it "parses a .com domain" do
      client.parse(name).should eq(['example','com'])
    end
    it "parses a .co.uk domain" do
      client.parse("example.co.uk").should eq(["example", "co.uk"])
    end
  end

  describe "#available?" do
    context "for an available domain" do
      it "returns true" do
        client.available?("128348925urtj.com").should be_true
      end
    end
    context "for an unavailable domain" do
      it "returns false" do
        client.available?("google.com").should be_false
      end
    end
  end

  describe "#purchase" do
    let(:registrant) do
      Registrar::Contact.new({
        :first_name => 'Anthony',
        :last_name => 'Eden',
        :address_1 => '123 SW 1st Street',
        :city => 'Anywhere',
        :country => 'US',
        :postal_code => '12121',
        :phone => '444 555 1212',
        :email => 'anthony@dnsimple.com'
      })
    end
    context "for an available .com" do
      let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.com" }
      let(:order) { client.purchase(name, registrant) }
      it "returns a completed order" do
        order.should be_complete
      end
      it "has the domain in the order" do
        order.domains.should_not be_empty
        order.domains[0].name.should eq(name)
      end
    end
  end
end
