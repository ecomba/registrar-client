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

  shared_examples "a real-time domain without extended attributes" do
    describe "#purchase" do
      let(:order) { client.purchase(name, registrant) }
      it "returns a completed order" do
        order.should be_complete
      end
      it "has a :closed status" do
        order.status.should eq(:closed)
      end
      it "has the domain in the order" do
        order.domains.should_not be_empty
        order.domains[0].name.should eq(name)
      end
    end
  end

  shared_examples "a real-time domain with extended attributes" do
    describe "#purchase" do
      let(:order) { client.purchase(name, registrant, purchase_options) }
      it "returns a completed order" do
        order.should be_complete
      end
      it "has a :closed status" do
        order.status.should eq(:closed)
      end
      it "has the domain in the order" do
        order.domains.should_not be_empty
        order.domains[0].name.should eq(name)
      end
    end
  end

  shared_examples "a non real-time domain with extended attributes" do
    describe "#purchase" do
      let(:order) { client.purchase(name, registrant, purchase_options) }
      it "returns an open order" do
        order.should_not be_complete
      end
      it "has an :open status" do
        order.status.should eq(:open)
      end
      it "has the domain in the order" do
        order.domains.should_not be_empty
        order.domains[0].name.should eq(name)
      end
    end
  end

  describe "#purchase" do
    context "for an available .com" do
      it_behaves_like "a real-time domain without extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.com" }
      end
    end
    context "for an available .net" do
      it_behaves_like "a real-time domain without extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.net" }
      end
    end
    context "for an available .org" do
      it_behaves_like "a real-time domain without extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.org" }
      end
    end
    context "for an available .info" do
      it_behaves_like "a real-time domain without extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.info" }
      end
    end
    context "for an available .biz" do
      it_behaves_like "a real-time domain without extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.biz" }
      end
    end
    context "for an available .us" do
      it_behaves_like "a real-time domain with extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.us" }
        let(:purchase_options) do
          purchase_options = Registrar::PurchaseOptions.new
          purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('us', :Nexus, :"US Citizen")
          purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('us', :Purpose, :"Personal")
          purchase_options
        end
      end
    end
    context "for an available .ca" do
      it_behaves_like "a real-time domain with extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.ca" }
        let(:registrant) do
          Registrar::Contact.new({
            :first_name => 'Anthony',
            :last_name => 'Eden',
            :address_1 => '123 SW 1st Street',
            :city => 'Anywhere',
            :state_province => 'BC',
            :state_province_choice => 'P',
            :country => 'CA',
            :postal_code => 'V6S 1P5',
            :phone => '+14445551212',
            :email => 'anthony@dnsimple.com'
          })
        end
        let(:purchase_options) do
          purchase_options = Registrar::PurchaseOptions.new
          purchase_options.name_servers << Registrar::NameServer.new('ns1.dnsimple.com')
          purchase_options.name_servers << Registrar::NameServer.new('ns2.dnsimple.com')
          purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('ca', :"Legal Type", :"Canadian Resident")
          purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('ca', :"Agreement Version", "2.0")
          purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('ca', :"Agreement Value", :Yes)
          purchase_options
        end
      end
    end
    context "for an available .io" do
      it_behaves_like "a non real-time domain with extended attributes" do
        let(:name) { "test-#{Time.now.to_i}-#{rand(10000)}.io" }
        let(:purchase_options) do
          purchase_options = Registrar::PurchaseOptions.new
          purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('io', :"Renewal Agreement", :Yes)
          purchase_options
        end
      end
    end
  end
  
end
