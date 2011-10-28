require 'spec_helper'

module Chargify2
  describe SiteResource do
    it "should have a URI of 'https://api.chargify.com/api/v2/sites'" do
      SiteResource.uri.should == 'https://api.chargify.com/api/v2/sites'
    end

    it "represents with the Site class" do
      SiteResource.representation.should == Site
    end

    describe "#read" do
      it "performs a GET request to 'https://api.chargify.com/api/v2/sites/123' (without authentication) when called with '123'" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123')
        SiteResource.read('123')
        a_request(:get, 'https://api.chargify.com/api/v2/sites/123').should have_been_made.once
      end

      it "returns a Site representation" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123')
        SiteResource.read('123').should be_a(Site)
      end

      it "returns nil when the status is not 200" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123').to_return(:status => 404)
        SiteResource.read('123').should be_nil
      end
    end

    describe "#list" do
      it "performs a GET request to 'https://api.chargify.com/api/v2/sites' (without authentication) when called with '123'" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites').to_return(:body => "[]")
        SiteResource.list
        a_request(:get, 'https://api.chargify.com/api/v2/sites').should have_been_made.once
      end

      it "returns an array of Site representations" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites').to_return(:body => "[]")
        SiteResource.list.should be_a(Array)
      end

      it "returns an empty array when no sites are found" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites').to_return(:status => 404)
        SiteResource.list.should  == []
      end
    end

    context "instance configured with a client and a non-standard base URI" do
      it "has a URI of 'http://www.example.com/sites'" do
        base_uri = 'http://www.example.com'
        client = Client.new(valid_client_credentials.merge(:base_uri => base_uri))
        SiteResource.new(client).uri.should == 'http://www.example.com/sites'
      end
    end

    context "instance configured with a valid client" do
      before(:each) do
        @client = Client.new(valid_client_credentials)
        @site_resource = SiteResource.new(@client)
      end

      it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/sites/123' (with authentication) when called with '123'" do
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123")
        SiteResource.read('123')
        a_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123").should have_been_made.once
      end

      it "returns a Site representation" do
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123")
        SiteResource.read('123').should be_a(Site)
      end
    end
  end
end

