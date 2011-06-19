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

  it "parses a .com domain" do
    client.parse(name).should eq(['example','com'])
  end

  it "parses a .co.uk domain" do
    client.parse("example.co.uk").should eq(["example", "co.uk"])
  end
end
