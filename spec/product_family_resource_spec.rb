require 'spec_helper'

module Chargify2
  describe ProductFamilyResource do
    it "should have a URI of 'https://api.chargify.com/api/v2/product_families'" do
      ProductFamilyResource.uri.should == 'https://api.chargify.com/api/v2/product_families'
    end

    it "represents with the ProductFamily class" do
      ProductFamilyResource.representation.should == ProductFamily
    end

    describe "creating a new ProductFamily resource" do
      let(:attributes) { { :name => "The most awesome product family in the world", :site_id => 1 } }

      it "makes a POST request to 'https://api.chargify.com/api/v2/product_families'" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/product_families\??(.*)/).to_return(:body => '{"product_family":{}}', :status => 201)
        ProductFamilyResource.create(attributes)
        a_request(:post, 'https://api.chargify.com/api/v2/product_families').should have_been_made.once
      end

      it "returns a product_family representation when it creates the resource successfully" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/product_families\??(.*)/).to_return(:body => '{"product_family":{}}', :status => 201)
        ProductFamilyResource.create(attributes).should be_a(ProductFamily)
      end

      it "returns false when the resource can't be created" do
        WebMock.stub_request(:post, /https?:\/\/api.chargify.com\/api\/v2\/product_families\??(.*)/).to_return(:status => 422)
        ProductFamilyResource.create({}).should be_false
      end
    end
  end
end

