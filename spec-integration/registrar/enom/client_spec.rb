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
    
  end
end
