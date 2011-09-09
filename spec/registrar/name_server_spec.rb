require 'spec_helper'

describe Registrar::NameServer do
  let(:nameserver1) { Registrar::NameServer.new('dns.example.com') }
  let(:nameserver2) { Registrar::NameServer.new('dns.example.com') }

  it 'is comparable to another namserver' do
    nameserver1.should == nameserver2
  end
end
