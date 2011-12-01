module Chargify2
  class Site < Hashie::Dash
    property :id
    property :test_mode
    property :currency
    property :seller_id
    property :configured_gateway
    property :name
    property :subdomain
    property :success
    property :request
    property :response

    def self.singular_name
      'site'
    end

    def self.plural_name
      'sites'
    end

    def request
      Request.new(self[:request] || {})
    end

    def response
      Response.new(self[:response] || {})
    end

    def successful?
      response.result.status_code.to_s == '200'
    end

    def errors
      (response.result.errors || []).map {|e| OpenCascade.new(e.deep_symbolize_keys)}
    end

    class Request < OpenCascade; end
    class Response < OpenCascade; end
  end
end

