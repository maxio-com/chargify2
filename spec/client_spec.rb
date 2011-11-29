require 'spec_helper'

module Chargify2
  describe Client do
    after do
      SiteResource.default_options.delete(:basic_auth)
    end

    let(:client) { Client.new(valid_client_credentials) }

    it "holds an api_id when passed to .new in the 'api_id' key" do
      client = Client.new('api_id' => "myid")
      client.api_id.should == 'myid'
    end

    it "holds an api_id when passed to .new in the :api_id key" do
      client = Client.new(:api_id => "myid")
      client.api_id.should == 'myid'
    end

    it "holds an api_password when passed to .new in the 'api_password' key" do
      client = Client.new('api_password' => "mypass")
      client.api_password.should == 'mypass'
    end

    it "holds an api_password when passed to .new in the :api_password key" do
      client = Client.new(:api_password => "mypass")
      client.api_password.should == 'mypass'
    end

    it "holds an api_secret when passed to .new in the 'api_secret' key" do
      client = Client.new('api_secret' => "mysecret")
      client.api_secret.should == 'mysecret'
    end

    it "holds an api_secret when passed to .new in the :api_secret key" do
      client = Client.new(:api_secret => "mysecret")
      client.api_secret.should == 'mysecret'
    end

    it "has a default base_uri of 'https://api.chargify.com/api/v2'" do
      client = Client.new(valid_client_credentials)
      client.base_uri.should == 'https://api.chargify.com/api/v2'
    end

    it "allows the setting of a different base_uri via initialization params" do
      client = Client.new(valid_client_credentials.merge(:base_uri => "http://example.com"))
      client.base_uri.should == 'http://example.com'
    end

    it "gives access to a pre-configured Direct instance through #direct" do
      direct = client.direct

      direct.should be_a(Direct)
      direct.client.should == client
    end

    it "accesses a CallResource through #calls" do
      client.calls.should be_a(CallResource)
    end

    it "accesses a SiteResource through #sites" do
      client.sites.should be_a(SiteResource)
    end

    it "accesses a TransactionResource through #transactions" do
      client.transactions.should be_a(TransactionResource)
    end
  end
end
