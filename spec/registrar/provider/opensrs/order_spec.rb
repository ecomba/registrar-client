require 'spec_helper'
require 'registrar/provider/opensrs/order'

describe Registrar::Provider::OpenSRS::Order do
  XML = <<EOX
<?xml version='1.0' encoding='UTF-8' standalone='no' ?>
<!DOCTYPE OPS_envelope SYSTEM 'ops.dtd'>
<OPS_envelope>
   <header>
      <version>0.9</version>
   </header>
   <body>
      <data_block>
         <dt_assoc>
            <item key="protocol">XCP</item>
            <item key="action">REPLY</item>
            <item key="object">DOMAIN</item>
            <item key="is_success">1</item>
            <item key="response_code">200</item>
            <item key="response_text">Command completed
successfully</item>
            <item key="attributes">
               <dt_assoc>
                  <item key="queue_date">04-MAR-2004 10:27:01</item>
                  <item key="request_data">
                     <dt_assoc>
                        <item key="ip">10.0.11.121</item>
                        <item key="username">purple</item>
                        <item key="action">SW_REGISTER</item>
                     </dt_assoc>
                  </item>
               </dt_assoc>
            </item>
         </dt_assoc>
      </data_block>
   </body>
</OPS_envelope>
EOX

  let(:order) { Registrar::Provider::OpenSRS::Order.new XML }

  it 'is a successful order' do
    order.should be_successful
  end

  it 'the order is completed' do
    order.should be_complete
  end
end
