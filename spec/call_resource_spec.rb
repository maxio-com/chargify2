require 'spec_helper'

module Chargify2
  describe CallResource do
    it "should have a URI of 'https://api.chargify.com/api/v2/calls'" do
      CallResource.uri.should == 'https://api.chargify.com/api/v2/calls'
    end

    it "represents with the Call class" do
      CallResource.representation.should == Call
    end
    
    describe "#read" do
      it "performs a GET request to 'https://api.chargify.com/api/v2/calls/123' (without authentication) when called with '123'" do
        # What is this 'a_request' method?
        pending 'Rewrite this test.'
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/calls/123')
        CallResource.read('123')
        a_request(:get, 'https://api.chargify.com/api/v2/calls/123').should have_been_made.once
      end
      
      it "returns a Call representation" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/calls/123')
        CallResource.read('123').should be_a(Call)
      end
    end
    
    context "instance configured with a client and a non-standard base URI" do
      it "has a URI of 'http://www.example.com/calls'" do
        base_uri = 'http://www.example.com'
        client = Client.new(valid_client_credentials.merge(:base_uri => base_uri))
        CallResource.new(client).uri.should == 'http://www.example.com/calls'
      end
    end
    
    context "instance configured with a valid client" do
      before(:each) do
        @client = Client.new(valid_client_credentials)
        @call_resource = CallResource.new(@client)
      end
      
      it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/calls/123' (with authentication) when called with '123'" do
        # What is this 'a_request' method?
        pending 'Rewrite this test.'
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/calls/123")
        CallResource.read('123')
        a_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/calls/123").should have_been_made.once
      end
      
      it "returns a Call representation" do
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/calls/123")
        CallResource.read('123').should be_a(Call)
      end
    end
  end
end
