require 'spec_helper'

module Chargify2
  describe ResumeResource do
    it "has the correct path" do
      expect(described_class.path).to eql('subscriptions/:subscription_id/resume')
    end

    it "represents the Resume resource" do
      expect(described_class.representation).to eql(Resume)
    end

    context 'with an instance configured with a client' do
      let(:client) { Client.new(valid_client_credentials) }
      let!(:resume_resource) { ResumeResource.new(client) }

      describe '#create' do
        it "performs a POST request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/subscriptions/:id/resume' (with authentication)" do
          WebMock.stub_request(:post, client_authenticated_uri(client, '/subscriptions/123/resume'))
          resume_resource.create(nil, subscription_id: 123)
          a_request(:post, client_authenticated_uri(client, '/subscriptions/123/resume')).should have_been_made.once
        end

        it "returns a Resume representation" do
          WebMock.stub_request(:post, client_authenticated_uri(client, '/subscriptions/123/resume'))

          resume_resource.create(nil, subscription_id: 123).should be_a(Response)
          resume_resource.create(nil, subscription_id: 123).resource.should be_a(Resume)
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
