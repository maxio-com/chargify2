require 'spec_helper'

module Chargify2
  describe ReasonCodeResource do
    it "should have a path of 'reason_codes'" do
      described_class.path.should == 'reason_codes'
    end

    it "represents with the ReasonCode class" do
      described_class.representation.should == ReasonCode
    end

    context 'with an instance configured with a client' do
      let(:client) { Client.new(valid_client_credentials) }
      let!(:reason_code_resource) { ReasonCodeResource.new(client) }


      describe '.list' do
        it 'ignores the instance configuration and uses class defaults' do
          WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/reason_codes')
          ReasonCodeResource.list
          a_request(:get, 'https://api.chargify.com/api/v2/reason_codes').should have_been_made.once
        end
      end

      describe '#list' do
        it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/reason_codes' (with authentication) when called" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/reason_codes'))
          reason_code_resource.list
          a_request(:get, client_authenticated_uri(client, '/reason_codes')).should have_been_made.once
        end

        it "returns an array of ReasonCode representations" do
          WebMock.stub_request(:get, client_authenticated_uri(client, '/reason_codes'))
          reason_code_resource.list.resource.all?{|rc| rc.is_a?(ReasonCode)}
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
