module Chargify2
  class ApiUser < Hashie::Dash
    property :id
    property :owner_id
    property :owner_type
    property :api_id
    property :password
    property :decrypted_api_secret
    property :url
    property :request
    property :response

    def self.singular_name
      'api_user'
    end

    def self.plural_name
      'api_users'
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

