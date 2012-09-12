module Chargify2
  class Call < Hashie::Dash
    property :id
    property :api_id
    property :timestamp
    property :nonce
    property :success
    property :request
    property :response

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
      (response.result.errors || []).map {|e| Hashie::Mash.new(e.symbolize_keys)}
    end

    class Request < Hashie::Mash; end
    class Response < Hashie::Mash; end
  end
end
