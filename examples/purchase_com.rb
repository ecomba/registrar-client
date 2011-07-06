require 'registrar'
require 'registrar/provider/enom'
config = YAML.load_file('examples/enom.yml')
provider = Registrar::Provider::Enom.new(config['url'], config['username'], config['password'])
contact = Registrar::Contact.new(:first_name => "John", :last_name => "Doe")
name = "test-domain-#{Time.now.to_i}-#{rand(10000)}.com"
order = provider.purchase(name, contact)
