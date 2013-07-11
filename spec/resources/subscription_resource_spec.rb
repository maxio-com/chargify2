require 'spec_helper'

module Chargify2
  describe SubscriptionResource do
    it "should have a path of 'subscriptions'" do
      SubscriptionResource.path.should == 'subscriptions'
    end

    it "represents with the Subscription class" do
      SubscriptionResource.representation.should == Subscription
    end

    context 'without an instance configured with a client' do
      describe '.read' do
        it "performs a GET request to 'https://api.chargify.com/api/v2/subscriptions/123' (without authentication) when called with '123'" do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/subscriptions/123')
          SubscriptionResource.read('123')
          a_request(:get, 'https://api.chargify.com/api/v2/subscriptions/123').should have_been_made.once
        end

        it "returns a Response object with a Subscription representation" do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/subscriptions/123')
          SubscriptionResource.read('123').should be_a(Response)
          SubscriptionResource.read('123').resource.should be_a(Subscription)
        end
      end
    end

    context 'with an instance configured with a client' do
      let(:client) { Client.new(valid_client_credentials) }
      let!(:subscription_resource) { SubscriptionResource.new(client) }

      describe '.read' do
        it 'ignores the instance configuration and uses class defaults' do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/subscriptions/123')
          SubscriptionResource.read('123')
          a_request(:get, 'https://api.chargify.com/api/v2/subscriptions/123').should have_been_made.once
        end
      end

      describe '#read' do
        it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/subscriptions/123' (with authentication) when called with '123'" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/subscriptions/123'))
          subscription_resource.read('123')
          a_request(:get, client_authenticated_uri(client, '/subscriptions/123')).should have_been_made.once
        end

        it "returns a Subscription representation" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/subscriptions/123'))
          subscription_resource.read('123').should be_a(Response)
          subscription_resource.read('123').resource.should be_a(Subscription)
        end
      end

      describe '.list' do
        it 'ignores the instance configuration and uses class defaults' do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/subscriptions')
          SubscriptionResource.list
          a_request(:get, 'https://api.chargify.com/api/v2/subscriptions').should have_been_made.once
        end
      end

      describe '#list' do
        it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/subscriptions' (with authentication) when called" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/subscriptions'))
          subscription_resource.list
          a_request(:get, client_authenticated_uri(client, '/subscriptions')).should have_been_made.once
        end

        it "returns an array of Subscription representations" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/subscriptions'))
          subscription_resource.list.resource.all?{|subsription| subscription.is_a?(Subscription)}
        end
      end

      context 'with a non-standard base URI' do
        let(:base_uri) { 'http://www.example.com' }
        let(:client) { Client.new(valid_client_credentials.merge(:base_uri => base_uri)) }

        describe '#read' do
          it "has a URI of 'http://www.example.com/subscriptions'" do
            WebMock.stub_request(:get, client_authenticated_uri(client, '/subscriptions/123'))
            subscription_resource.read('123')
            a_request(:get, client_authenticated_uri(client, '/subscriptions/123')).should have_been_made.once
          end
        end
      end

      describe '#destroy' do
        it "performs a DELETE request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/subscriptions/123' (with authentication) when called with '123'" do
          WebMock.stub_request(:delete, client_authenticated_uri(client, '/subscriptions/123'))
          subscription_resource.destroy('123')
          a_request(:delete, client_authenticated_uri(client, '/subscriptions/123')).should have_been_made.once
        end

        it "returns a Subscription representation" do
          WebMock.stub_request(:delete, client_authenticated_uri(client, '/subscriptions/123'))
          subscription_resource.destroy('123').should be_a(Response)
          subscription_resource.destroy('123', {:cancellation_message => 'see ya'}).resource.should be_a(Subscription)
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
