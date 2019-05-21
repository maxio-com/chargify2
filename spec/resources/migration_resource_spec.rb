require 'spec_helper'

module Chargify2
  describe MigrationResource do
    it 'has the correct path' do
      expect(described_class.path).to eql('migrations')
    end

    it 'represents the Migration resource' do
      expect(described_class.representation).to eql(Migration)
    end

    context 'with an instance configured with a client' do
      let(:client) { Client.new(valid_client_credentials) }
      let!(:migration_resource) { MigrationResource.new(client) }

      describe '#preview' do
        it "performs a POST request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/migrations/preview' (with authentication)" do
          WebMock.stub_request(:post, client_authenticated_uri(client, '/migrations/preview'))
          migration_resource.preview(subscription_id: 123, product_id: 1)
          a_request(:post, client_authenticated_uri(client, '/migrations/preview')).should have_been_made.once
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
