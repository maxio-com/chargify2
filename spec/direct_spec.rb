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

          sp.api_id.should_not     be_empty
          sp.timestamp.should      be_nil
          sp.nonce.should          be_nil
          sp.data.should           be_nil
          sp.signature.should_not  be_empty
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

    describe "#response_parameters" do
      let(:direct) { Direct.new(client) }
      
      it "generates a new ResponseParameters instance given a hash of response params" do
        direct.response_parameters({}).should be_a(Direct::ResponseParameters)
      end
    end
  end
end
