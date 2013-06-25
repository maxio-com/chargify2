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
      Request[self[:request] || {}]
    end
    
    def response
      Response[self[:response] || {}]
    end
    
    def successful?
      response.result.status_code.to_s == '200'
    end
    
    def errors
      (response.result.errors || []).map {|e| Hashery::OpenCascade[e.symbolize_keys]}
    end
    
    class Request < Hashery::OpenCascade; end
    class Response < Hashery::OpenCascade; end
  end
end
