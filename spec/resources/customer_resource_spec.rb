require 'spec_helper'

module Chargify2
  describe CustomerResource do
    it "should have a path of 'customers'" do
      CustomerResource.path.should == 'customers'
    end

    it "represents with the Customer class" do
      CustomerResource.representation.should == Customer
    end

    context 'without an instance configured with a client' do
      describe '.read' do
        it "performs a GET request to 'https://api.chargify.com/api/v2/customers/123' (without authentication) when called with '123'" do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/customers/123')
          CustomerResource.read('123')
          a_request(:get, 'https://api.chargify.com/api/v2/customers/123').should have_been_made.once
        end

        it "returns a Response object with a Customer representation" do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/customers/123')
          CustomerResource.read('123').should be_a(Response)
          CustomerResource.read('123').resource.should be_a(Customer)
        end
      end
    end

    context 'with an instance configured with a client' do
      let(:client) { Client.new(valid_client_credentials) }
      let!(:customer_resource) { CustomerResource.new(client) }

      describe '.read' do
        it 'ignores the instance configuration and uses class defaults' do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/customers/123')
          CustomerResource.read('123')
          a_request(:get, 'https://api.chargify.com/api/v2/customers/123').should have_been_made.once
        end
      end

      describe '#read' do
        it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/customers/123' (with authentication) when called with '123'" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/customers/123'))
          customer_resource.read('123')
          a_request(:get, client_authenticated_uri(client, '/customers/123')).should have_been_made.once
        end

        it "returns a Customer representation" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/customers/123'))
          customer_resource.read('123').should be_a(Response)
          customer_resource.read('123').resource.should be_a(Customer)
        end
      end

      describe '.list' do
        it 'ignores the instance configuration and uses class defaults' do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/customers')
          CustomerResource.list
          a_request(:get, 'https://api.chargify.com/api/v2/customers').should have_been_made.once
        end
      end

      describe '#list' do
        it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/customers' (with authentication) when called" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/customers'))
          customer_resource.list
          a_request(:get, client_authenticated_uri(client, '/customers')).should have_been_made.once
        end

        it "returns an array of Customer representations" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/customers'))
          customer_resource.list.resource.all?{|customer| customer.is_a?(Customer)}
        end
      end

      describe '#update' do
        it "performs a PUT request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/customers/123' (with authentication) when called with '123'" do
          WebMock.stub_request(:put, client_authenticated_uri(client, '/customers/123'))
          customer_resource.update('123', {:first_name => 'Nathan'})
          a_request(:put, client_authenticated_uri(client, '/customers/123')).should have_been_made.once
        end

        it "returns a Customer representation" do
          WebMock.stub_request(:put, client_authenticated_uri(client, '/customers/123'))
          customer_resource.update('123', {:first_name => 'Nathan'}).should be_a(Response)
          customer_resource.update('123', {:first_name => 'Nathan'}).resource.should be_a(Customer)
        end
      end

      context 'with a non-standard base URI' do
        let(:base_uri) { 'http://www.example.com' }
        let(:client) { Client.new(valid_client_credentials.merge(:base_uri => base_uri)) }

        describe '#read' do
          it "has a URI of 'http://www.example.com/customers'" do
            WebMock.stub_request(:get, client_authenticated_uri(client, '/customers/123'))
            customer_resource.read('123')
            a_request(:get, client_authenticated_uri(client, '/customers/123')).should have_been_made.once
          end
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

