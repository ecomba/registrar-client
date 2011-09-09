require 'spec_helper'

require 'builder'
require 'registrar/provider/opensrs/name_server_list'

describe Registrar::Provider::OpenSRS::NameServerList do

  let(:list){ Registrar::Provider::OpenSRS::NameServerList.new(purchase_options) }
  
  let(:nameserver1) { Registrar::NameServer.new('ns1.example.com') }
  let(:nameserver2) { Registrar::NameServer.new('ns2.example.com') }

  let(:purchase_options) do
    purchase_options = Registrar::PurchaseOptions.new
    purchase_options.name_servers << nameserver1
    purchase_options.name_servers << nameserver2
    purchase_options
  end

  let(:xml){ %q{<dt_array><item key="0"><dt_assoc><item key="sortorder">1</item><item key="name">ns1.example.com</item></dt_assoc></item><item key="1"><dt_assoc><item key="sortorder">2</item><item key="name">ns2.example.com</item></dt_assoc></item></dt_array>} }

  it 'has a list of nameservers' do
    list.nameservers.should eq [nameserver1, nameserver2]
  end
  
  it 'renders the xml' do
    list.to_xml(Builder::XmlMarkup.new).should eq xml
  end
end
