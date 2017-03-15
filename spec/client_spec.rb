require 'spec_helper'

module Chargify2
  describe Client do
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

    it "accesses a SubscriptionResource through #subscriptions" do
      client.subscriptions.should be_a(SubscriptionResource)
    end

    it "accesses a CustomerResource through #customers" do
      client.customers.should be_a(CustomerResource)
    end

    it "accesses a ProductResource through #products" do
      client.products.should be_a(ProductResource)
    end

    it "accesses a HoldResource through #holds" do
      client.holds.should be_a(HoldResource)
    end

    it "accesses a ResumeResource through #resumes" do
      client.resumes.should be_a(ResumeResource)
    end
  end
end
