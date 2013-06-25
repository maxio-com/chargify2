require 'spec_helper'

module Chargify2
  describe CallResource do
    it "should have a path of 'calls'" do
      CallResource.path.should == 'calls'
    end

    it "represents with the Call class" do
      CallResource.representation.should == Call
    end

    context 'without an instance configured with a client' do
      describe '.read' do
        it "performs a GET request to 'https://api.chargify.com/api/v2/calls/123' (without authentication) when called with '123'" do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/calls/123')
          CallResource.read('123')
          a_request(:get, 'https://api.chargify.com/api/v2/calls/123').should have_been_made.once
        end

        it "returns a Call representation" do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/calls/123')
          CallResource.read('123').should be_a(Call)
        end
      end
    end

    context 'with an instance configured with a client' do
      let(:client) { Client.new(valid_client_credentials) }
      let!(:call_resource) { CallResource.new(client) }

      describe '.read' do
        it 'ignores the instance configuration and uses class defaults' do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/calls/123')
          CallResource.read('123')
          a_request(:get, 'https://api.chargify.com/api/v2/calls/123').should have_been_made.once
        end
      end

      describe '#read' do
        it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/calls/123' (with authentication) when called with '123'" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/calls/123'))
          call_resource.read('123')
          a_request(:get, client_authenticated_uri(client, '/calls/123')).should have_been_made.once
        end

        it "returns a Call representation" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/calls/123'))
          call_resource.read('123').should be_a(Call)
        end
      end

      context 'with a non-standard base URI' do
        let(:base_uri) { 'http://www.example.com' }
        let(:client) { Client.new(valid_client_credentials.merge(:base_uri => base_uri)) }

        describe '#read' do
          it "has a URI of 'http://www.example.com/calls'" do
            WebMock.stub_request(:get, client_authenticated_uri(client, '/calls/123'))
            call_resource.read('123')
            a_request(:get, client_authenticated_uri(client, '/calls/123')).should have_been_made.once
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
