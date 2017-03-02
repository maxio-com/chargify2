require 'spec_helper'

module Chargify2
  describe HoldResource do
    it "has the correct path" do
      expect(described_class.path).to eql('subscriptions/:subscription_id/hold')
    end

    it "represents the Hold resource" do
      expect(described_class.representation).to eql(Hold)
    end

    context 'with an instance configured with a client' do
      let(:client) { Client.new(valid_client_credentials) }
      let!(:hold_resource) { HoldResource.new(client) }

      describe '#create' do
        it "performs a POST request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/subscriptions/:id/hold' (with authentication)" do
          WebMock.stub_request(:post, client_authenticated_uri(client, '/subscriptions/123/hold'))
          hold_resource.create(nil, subscription_id: 123)
          a_request(:post, client_authenticated_uri(client, '/subscriptions/123/hold')).should have_been_made.once
        end

        it "returns a Hold representation" do
          WebMock.stub_request(:post, client_authenticated_uri(client, '/subscriptions/123/hold'))

          hold_resource.create(nil, subscription_id: 123).should be_a(Response)
          hold_resource.create(nil, subscription_id: 123).resource.should be_a(Hold)
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
