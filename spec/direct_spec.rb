require 'spec_helper'

module Chargify2
  describe Direct do
    let(:client) { Client.new(valid_client_credentials) }

    it "creates a creates a new instance when passed a Client" do
      Direct.new(client).should be_a(Direct)
    end
    
    it "raises an argument error when creating a new instance without a Client" do
      lambda { Direct.new('foo') }.should raise_error(ArgumentError)
    end
    
    describe "#secure_parameters" do
      let(:direct) { Direct.new(client) }

      context "with no arguments" do
        it "returns a SecureParameters instance with only the defaults set" do
          sp = direct.secure_parameters

          sp.should be_a(Direct::SecureParameters)

          sp.api_id.should_not     be_blank
          sp.timestamp.should      be_blank
          sp.nonce.should          be_blank
          sp.data.should           be_blank
          sp.signature.should_not  be_blank
        end
      end
      
      it "sets the api_id and secret values on the SecureParameters instance from the client" do
        sp = direct.secure_parameters
        
        sp.api_id.should == client.api_id
        sp.secret.should == client.api_secret
      end
      
      it "allows the setting of secure parameters via the arguments hash" do
        timestamp = "1234"
        nonce = "7890"
        data = {'redirect_uri' => 'http://www.example.com'}
        
        sp = direct.secure_parameters('timestamp' => timestamp, 'nonce' => nonce, 'data' => data)
        
        sp.timestamp.should == timestamp
        sp.nonce.should     == nonce
        sp.data.should      == data.symbolize_keys
      end
    end

    describe ".signature" do
      it "generates an HMAC-SHA1 hash from the given +message+ and +secret+" do
        message = "this is the message to hash"
        secret = "foobarjones"
      
        # Used the HMAC-SHA1 generator here: http://hash.online-convert.com/sha1-generator
        Direct.signature(message, secret).should == "459cceb1ad074a9082daba5c0788f12fdd6cdbd6"
      end
    end

    describe "#result" do
      let(:direct) { Direct.new(client) }
      
      it "generates a new Result instance given a hash of result params" do
        direct.result({}).should be_a(Direct::Result)
      end
    end
    
    describe Direct::Result do
      describe "#verified?" do
        it "returns true when the calculated signature of the result params matches the received signature" do
          api_id = '1c016050-498a-012e-91b1-005056a216ab'
          status_code = '200'
          result_code = '2000'
          call_id = '1234'
          
          # Used the generator here: http://hash.online-convert.com/sha1-generator
          # ... with message: "1c016050-498a-012e-91b1-005056a216ab20020001234"
          # ... and secret: "p5lxQ804MYtwZecFWNOT"
          # ... to get: "9d1b9139d6c49720faa0b2b6207c95060e6695d4"
          signature = "9d1b9139d6c49720faa0b2b6207c95060e6695d4"
          
          r = Direct::Result.new({
            'api_id' => api_id,
            'status_code' => status_code,
            'result_code' => result_code,
            'call_id' => call_id,
            'signature' => signature}, client)
          
          r.verified?.should be_true
        end
        
        it "returns false when the calculated signature of the result params is different from the received signature" do
          r = Direct::Result.new({
            'api_id' => client.api_id,
            'status_code' => '2',
            'result_code' => '3',
            'call_id' => '4',
            'signature' => '5'}, client)
          
          r.verified?.should be_false
        end
        
        it "returns false when the calculated signature is correct but the api_id does not match the client's'" do
          api_id = '1c016050-498a-012e-91b1-005056a216ab'
          status_code = '200'
          result_code = '2000'
          call_id = '1234'
          
          # Used the generator here: http://hash.online-convert.com/sha1-generator
          # ... with message: "1c016050-498a-012e-91b1-005056a216ab20020001234"
          # ... and secret: "p5lxQ804MYtwZecFWNOT"
          # ... to get: "9d1b9139d6c49720faa0b2b6207c95060e6695d4"
          signature = "9d1b9139d6c49720faa0b2b6207c95060e6695d4"

          client_credentials = valid_client_credentials
          client_credentials[:api_id] = '1234'
          different_client = Client.new(client_credentials)
          r = Direct::Result.new({
            'api_id' => api_id,
            'status_code' => status_code,
            'result_code' => result_code,
            'call_id' => call_id,
            'signature' => signature}, different_client)
          
          r.verified?.should be_false
        end
      end
    end
  end
end