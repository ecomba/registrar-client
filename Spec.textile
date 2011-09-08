








  

  domain.name_servers
  => [#<Registrar::NameServer:"ns1.example.com">, #<Registrar::Domain:"ns2.example.com">]

To find an already purchased domain by its name so you can get more details:

  domain = client.find('example.com')
  => #<Registrar::Domain:"example.com">

To transfer a domain

  transfer_order = client.transfer(name, registrant)

Or, with purchase options:

  transfer_options = Registrar::TransferOptions.new
  purchase_options.name_servers << Registrar::NameServer.new('ns1.example.com')
  purchase_options.name_servers << Registrar::NameServer.new('ns2.example.com')
  purchase_options.extended_attributes << Registrar::ExtendedAttribute.new('name', 'value')
  transfer_order = client.transfer(name, registrant, transfer_options)

To renew a domain:

  domain.expires_on
  => '2011-03-04'
  domain.renew
  => true
  domain.expires_on
  => '2012-03-04'

To delete a registration (this will not refund):

  ip_address = '1.2.3.4'
  domain.delete(ip_address)
  => true

To get a list of supported TLDs along with properties:

  tld = client.tlds.first
  tld.name
  => "com"
  tld.max_years
  => 10
 
  
