require 'spec_helper'

module Chargify2
  describe TransactionResource do
    it "should have a URI of 'https://api.chargify.com/api/v2/transactions'" do
      TransactionResource.uri.should == 'https://api.chargify.com/api/v2/transactions'
    end

    it "represents with the Transaction class" do
      TransactionResource.representation.should == Transaction
    end

    describe "creating a Transaction" do
      it "should return false" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/transactions\??(.*)/).to_return(:body => '{"transaction":{}}', :status => 501)
        TransactionResource.create({:foo => 'bar'}).should be_false
      end

      # it "should return a status code of '501 Not Implemented'" do
      #   WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/transactions\??(.*)/).to_return(:status => 501)
      #   TransactionResource.create({:foo => 'bar'}).status.should == '501 Not Implemented'
      # end
    end

    describe "updating a Transaction" do
      it "should return false" do
        WebMock.stub_request(:put, /https?:\/\/api.chargify.com\/api\/v2\/transactions\??(.*)/).to_return(:status => 501)
        TransactionResource.update(123, {:foo => 'bar'}).should be_false
      end

      # it "should return a status code of '501 Not Implemented'" do
      #   WebMock.stub_request(:put, /https?:\/\/api.chargify.com\/api\/v2\/transactions\??(.*)/).to_return(:body => "", :status => 501)
      #   TransactionResource.update(123, {:foo => 'bar'}).status.should == '501 Not Implemented'
      # end
    end

    describe "reading a Transaction resource" do
      it "performs a GET request to 'https://api.chargify.com/api/v2/transactions/123' (without authentication) when called with '123'" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/transactions/123').to_return(:body => '{"transaction":{}}', :status => 200)
        TransactionResource.read('123')
        a_request(:get, 'https://api.chargify.com/api/v2/transactions/123').should have_been_made.once
      end

      it "returns a Transaction representation" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/transactions/123').to_return(:body => '{"transaction":{}}', :status => 200)
        TransactionResource.read('123').should be_a(Transaction)
      end

      it "returns nil when the status is not 200" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/transactions/123').to_return(:status => 404)
        TransactionResource.read('123').should be_nil
      end
    end

    describe "retrieving a list of Transaction resources" do
      it "performs a GET request to 'https://api.chargify.com/api/v2/transactions' (without authentication) when called with '123'" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/transactions').to_return(:body => '{"transactions":{}}', :status => 200)
        TransactionResource.list
        a_request(:get, 'https://api.chargify.com/api/v2/transactions').should have_been_made.once
      end

      it "returns an array of Transaction representations" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/transactions').to_return(:body => '{"transactions":{}}', :status => 200)
        TransactionResource.list.should be_a(Array)
      end

      it "returns an empty array when no transactions are found" do
        WebMock.stub_request(:get, 'https://api.chargify.com/api/v2/transactions').to_return(:body => '{"transactions":{}}', :status => 404)
        TransactionResource.list.should  == []
      end
    end

    context "instance configured with a client and a non-standard base URI" do
      it "has a URI of 'http://www.example.com/transactions'" do
        base_uri = 'http://www.example.com'
        client = Client.new(valid_client_credentials.merge(:base_uri => base_uri))
        TransactionResource.new(client).uri.should == 'http://www.example.com/transactions'
      end
    end

    context "instance configured with a valid client" do
      before(:each) do
        @client = Client.new(valid_client_credentials)
        @transaction_resource = TransactionResource.new(@client)
      end

      it "performs a GET request to 'https://<api_login>:<api_password>@api.chargify.com/api/v2/transactions/123' (with authentication) when called with '123'" do
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/transactions/123").to_return(:body => '{"transaction":{}}', :status => 200)

        TransactionResource.read('123')
        a_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/transactions/123").should have_been_made.once
      end

      it "returns a Transaction representation" do
        WebMock.stub_request(:get, "https://#{@client.api_id}:#{@client.api_password}@api.chargify.com/api/v2/transactions/123").to_return(:body => '{"transaction":{}}', :status => 200)
        TransactionResource.read('123').should be_a(Transaction)
      end
    end
  end
end


