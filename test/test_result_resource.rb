require 'helper'

module Chargify2
  class TestResultResource < Test::Unit::TestCase
    def test_uri
      client = Chargify2::Client.new(:api_id => "1234", :api_password => "mypassword", :api_secret => 'myapisecret')
      Result.client = client
      assert_equal Result.uri, "#{Result.base_uri}/results"
    end
  
    def test_read
      client = Chargify2::Client.new(:api_id => "1234", :api_password => "mypassword", :api_secret => 'myapisecret')
      Result.client = client

      # stub_request(:get, "#{Resource.base_uri}/results/1234")

      Result.read(1234)

      assert_requested :get, "#{Resource.base_uri}/results/1234", :times => 1
    end
  end
end