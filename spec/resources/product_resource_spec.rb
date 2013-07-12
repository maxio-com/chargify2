require 'spec_helper'

module Chargify2
  describe ProductResource do
    it "should have a path of 'products'" do
      described_class.path.should == 'products'
    end

    it "represents with the Product class" do
      described_class.representation.should == Product
    end

    context 'without an instance configured with a client' do
      describe '.read' do
        it "performs a GET request to 'https://api.chargify.com/api/v2/products/123' (without authentication) when called with '123'" do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/products/123')
          described_class.read('123')
          a_request(:get, 'https://api.chargify.com/api/v2/products/123').should have_been_made.once
        end

        it "returns a Response object with a Product representation" do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/products/123')
          described_class.read('123').should be_a(Response)
          described_class.read('123').resource.should be_a(Product)
        end
      end
    end

    context 'with an instance configured with a client' do
      let(:client) { Client.new(valid_client_credentials) }
      let!(:product_resource) { described_class.new(client) }

      describe '.read' do
        it 'ignores the instance configuration and uses class defaults' do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/products/123')
          described_class.read('123')
          a_request(:get, 'https://api.chargify.com/api/v2/products/123').should have_been_made.once
        end
      end

      describe '#read' do
        it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/products/123' (with authentication) when called with '123'" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/products/123'))
          product_resource.read('123')
          a_request(:get, client_authenticated_uri(client, '/products/123')).should have_been_made.once
        end

        it "returns a Product representation" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/products/123'))
          product_resource.read('123').should be_a(Response)
          product_resource.read('123').resource.should be_a(Product)
        end
      end

      describe '.list' do
        it 'ignores the instance configuration and uses class defaults' do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/products')
          described_class.list
          a_request(:get, 'https://api.chargify.com/api/v2/products').should have_been_made.once
        end
      end

      describe '#list' do
        it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/products' (with authentication) when called" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/products'))
          product_resource.list
          a_request(:get, client_authenticated_uri(client, '/products')).should have_been_made.once
        end

        it "returns an array of Product representations" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/products'))
          product_resource.list.resource.all?{|product| product.is_a?(Product)}
        end
      end
    end

    def client_authenticated_uri(client, path)
      uri = URI(client.base_uri)
      uri.user = client.api_id
      uri.password = client.api_password

      uri.to_s + path
    end
  end
end

