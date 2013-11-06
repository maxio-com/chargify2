require 'spec_helper'

describe Chargify2::Resource do
  class Foo < Chargify2::Representation
  end

  class FooResource < Chargify2::Resource
    def self.path
      "wibbles/:foo/:bar"
    end

    def self.representation
      Foo
    end
  end

  let(:params){ { foo: 123, bar: 'abcd' } }

  describe ".assemble_path" do
    it "substitutes values from a hash" do
      expect(FooResource.assemble_path(params)).to eql("wibbles/123/abcd")
    end

    it "removes the params that are used in creating the path" do
      params[:woot] = 'boom'
      FooResource.assemble_path(params)
      expect(params).to eql({woot: 'boom'})
    end
  end

  describe '.list' do
    it 'ignores the instance configuration and uses class defaults' do
      WebMock.stub_request(:get, "https://api.chargify.com/api/v2/wibbles/123/abcd")
      FooResource.list(params)
      a_request(:get, "https://api.chargify.com/api/v2/wibbles/123/abcd").should have_been_made.once
    end
  end

end
