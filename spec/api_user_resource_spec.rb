require 'spec_helper'

module Chargify2
  describe SiteResource do
    it "should have a URI of 'https://api.chargify.com/api/v2/api_users'" do
      ApiUserResource.uri.should == 'https://api.chargify.com/api/v2/sites/:site_id/api_users'
    end

    it "represents with the ApiUser class" do
      ApiUserResource.representation.should == ApiUser
    end

    describe "creating a new ApiUser resource" do
      let(:attributes) { { :site_id => 1, :password => "password" } }

      it "makes a POST request to 'https://api.chargify.com/api/v2/api_users'" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/sites\/1\/api_users\??(.*)/).to_return(:body => '{"api_user":{}}', :status => 201)
        ApiUserResource.create(attributes)
        a_request(:post, 'https://api.chargify.com/api/v2/sites/1/api_users?api_user%5Bpassword%5D=password').should have_been_made.once
      end

      it "returns a site representation when it creates the resource successfully" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/sites\/1\/api_users\??(.*)/).to_return(:body => '{"api_user":{}}', :status => 201)
        ApiUserResource.create(attributes).should be_a(ApiUser)
      end

      it "returns false when the resource can't be created" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/sites\/1\/api_users\??(.*)/).to_return(:status => 422)
        ApiUserResource.create({:site_id => 1}).should be_false
      end
    end

    describe "reading a Site resource" do
      # it "performs a GET request to 'https://api.chargify.com/api/v2/sites/123' (without authentication) when called with '123'" do
      #   WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123').to_return(:body => '{"site":{}}')
      #   SiteResource.read('123')
      #   a_request(:get, 'https://api.chargify.com/api/v2/sites/123').should have_been_made.once
      # end

      # it "returns a Site representation" do
      #   WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123').to_return(:body => '{"site":{}}')
      #   SiteResource.read('123').should be_a(Site)
      # end

      # it "returns nil when the status is not 200" do
      #   WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123').to_return(:status => 404)
      #   SiteResource.read('123').should be_nil
      # end
    end

    context "instance configured with a client and a non-standard base URI" do
      it "has a URI of 'http://www.example.com/sites'" do
        base_uri = 'http://www.example.com'
        client = Client.new(valid_client_credentials.merge(:base_uri => base_uri))
        ApiUserResource.new(client).uri.should == 'http://www.example.com/sites/:site_id/api_users'
      end
    end

    # context "instance configured with a valid client" do
    #   before(:each) do
    #     @client = Client.new(valid_client_credentials)
    #     @site_resource = SiteResource.new(@client)
    #   end

    #   it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/sites/123' (with authentication) when called with '123'" do
    #     WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123").to_return(:body => '{"site":{}}')
    #     SiteResource.read('123')
    #     a_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123").should have_been_made.once
    #   end

    #   it "returns a Site representation" do
    #     WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123").to_return(:body => '{"site":{}}')
    #     SiteResource.read('123').should be_a(Site)
    #   end
    # end
  end
end

