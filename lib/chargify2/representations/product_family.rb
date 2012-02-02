module Chargify2
  class ProductFamily < Hashie::Dash
    property :id
    property :name
    property :handle
    property :accounting_code
    property :description
    property :url
    property :request
    property :response

    def self.singular_name
      'product_family'
    end

    def self.plural_name
      'product_families'
    end

    def request
      Request.new(self[:request].deep_symbolize_keys || {})
    end

    def response
      Response.new(self[:response].deep_symbolize_keys || {})
    end

    def successful?
      response.result.status_code.to_s == '200'
    end

    def errors
      (response.result.errors || []).map! {|e| OpenCascade.new(e.deep_symbolize_keys)}
    end

    class Request < OpenCascade; end
    class Response < OpenCascade; end
  end
end

