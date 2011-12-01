require 'spec_helper'

module Chargify2
  describe SiteResource do
    it "should have a URI of 'https://api.chargify.com/api/v2/sites'" do
      SiteResource.uri.should == 'https://api.chargify.com/api/v2/sites'
    end

    it "represents with the Site class" do
      SiteResource.representation.should == Site
    end

    describe "deleting a Site resource" do
      it "makes a DELETE request to 'https://api.chargify.com/api/v2/sites'" do
        WebMock.stub_request(:delete, 'https://api.chargify.com/api/v2/sites/123')
        SiteResource.destroy(123)
        a_request(:delete, 'https://api.chargify.com/api/v2/sites/123').should have_been_made.once
      end

      it "returns true after the resource is successfully deleted" do
        WebMock.stub_request(:delete, 'https://api.chargify.com/api/v2/sites/123').to_return(:status => 204)
        SiteResource.destroy(123).should be_true
      end

      it "returns false when the resource can't be deleted" do
        WebMock.stub_request(:delete, 'https://api.chargify.com/api/v2/sites/123').to_return(:status => 422)
        SiteResource.destroy(123).should be_false
      end
    end

    describe "updating a Site resource" do
      let(:attributes) { { :name => 'Changed name' } }

      it "makes a PUT request to 'https://api.chargify.com/api/v2/sites'" do
        WebMock.stub_request(:put, /https?:\/\/api.chargify.com\/api\/v2\/sites\/123\??(.*)/).to_return(:body => '{"site":{}}', :status => 200)
        SiteResource.update('123', attributes)
        a_request(:put, 'https://api.chargify.com/api/v2/sites/123?site%5Bname%5D=Changed%20name').should have_been_made.once
      end

      it "returns a Site representation when it updates the resource successfully" do
        WebMock.stub_request(:put, /https?:\/\/api.chargify.com\/api\/v2\/sites\/123\??(.*)/).to_return(:body => '{"site":{}}', :status => 200)
        SiteResource.update('123', attributes).should be_a(Site)
      end

      it "returns false when the resource can't be updated" do
        WebMock.stub_request(:put, /https?:\/\/api.chargify.com\/api\/v2\/sites\/fake-site-id\??(.*)/).to_return(:status => 404)
        SiteResource.update('fake-site-id', attributes).should be_false
      end
    end

    describe "creating a new Site resource" do
      let(:attributes) { { :name => "Acme Test", :subdomain => "acme-test" } }

      it "makes a POST request to 'https://api.chargify.com/api/v2/sites'" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/sites\??(.*)/).to_return(:body => '{"site":{}}', :status => 201)
        SiteResource.create(attributes)
        a_request(:post, 'https://api.chargify.com/api/v2/sites?site%5Bname%5D=Acme%20Test&site%5Bsubdomain%5D=acme-test').should have_been_made.once
      end

      it "returns a site representation when it creates the resource successfully" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/sites\??(.*)/).to_return(:body => '{"site":{}}', :status => 201)
        SiteResource.create(attributes).should be_a(Site)
      end

      it "returns false when the resource can't be created" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/sites\??(.*)/).to_return(:status => 422)
        SiteResource.create({}).should be_false
      end
    end

    describe "reading a Site resource" do
      it "performs a GET request to 'https://api.chargify.com/api/v2/sites/123' (without authentication) when called with '123'" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123').to_return(:body => '{"site":{}}')
        SiteResource.read('123')
        a_request(:get, 'https://api.chargify.com/api/v2/sites/123').should have_been_made.once
      end

      it "returns a Site representation" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123').to_return(:body => '{"site":{}}')
        SiteResource.read('123').should be_a(Site)
      end

      it "returns nil when the status is not 200" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites/123').to_return(:status => 404)
        SiteResource.read('123').should be_nil
      end
    end

    describe "retrieving a list of Site resources" do
      it "performs a GET request to 'https://api.chargify.com/api/v2/sites' (without authentication) when called with '123'" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites').to_return(:body => '{"sites":{}}', :status => 200)
        SiteResource.list
        a_request(:get, 'https://api.chargify.com/api/v2/sites').should have_been_made.once
      end

      it "returns an array of Site representations" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/sites').to_return(:body => '{"sites":{}}', :status => 200)
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
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123").to_return(:body => '{"site":{}}')
        SiteResource.read('123')
        a_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123").should have_been_made.once
      end

      it "returns a Site representation" do
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/sites/123").to_return(:body => '{"site":{}}')
        SiteResource.read('123').should be_a(Site)
      end
    end
  end
end

