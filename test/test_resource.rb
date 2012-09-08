require 'helper'

module Chargify2
  class TestResource < Test::Unit::TestCase
    def test_resource_uri_without_client_connected
      client_before = Resource.client
      Resource.client = nil
      assert_raise ClientConnectionError do
        Resource.uri
      end
      Resource.client = client_before
    end
    
    def test_resource_uri_with_client_connected
      client = Chargify2::Client.new(:api_id => "1234", :api_password => "mypassword", :api_secret => 'myapisecret')
      Resource.client = client
      assert_equal Resource.uri, "#{client.base_uri}/resources"
    end
  
    # def test_list_without_access_token
    #   as
    # end
  end
end