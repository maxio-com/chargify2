require 'spec_helper'

module Chargify2
  describe SubscriptionResource do
    it "should have a URI of 'https://api.chargify.com/api/v2/subscriptions'" do
      SubscriptionResource.uri.should == 'https://api.chargify.com/api/v2/subscriptions'
    end

    it "represents with the Subscription class" do
      SubscriptionResource.representation.should == Subscription
    end
    
    describe "#read" do
      it "performs a GET request to 'https://api.chargify.com/api/v2/subscriptions/123' (without authentication) when called with '123'" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/subscriptions/123')
        SubscriptionResource.read('123')
        a_request(:get, 'https://api.chargify.com/api/v2/subscriptions/123').should have_been_made.once
      end
      
      it "returns a Subscription representation" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/subscriptions/123')
        SubscriptionResource.read('123').should be_a(Subscription)
      end
    end
    
    context "instance configured with a client and a non-standard base URI" do
      it "has a URI of 'http://www.example.com/subscriptions'" do
        base_uri = 'http://www.example.com'
        client = Client.new(valid_client_credentials.merge(:base_uri => base_uri))
        SubscriptionResource.new(client).uri.should == 'http://www.example.com/subscription'
      end
    end
    
    context "instance configured with a valid client" do
      before(:each) do
        @client = Client.new(valid_client_credentials)
        @subscription_resource = SubscriptionResource.new(@client)
      end
      
      it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/subscriptions/123' (with authentication) when called with '123'" do
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/subscriptions/123")
        SubscriptionResource.read('123')
        a_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/subscriptions/123").should have_been_made.once
      end
      
      it "returns a Subscription representation" do
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/subscriptions/123")
        SubscriptionResource.read('123').should be_a(Subscription)
      end
    end
  end
end
