module Chargify2
  class Call < Hashie::Dash
    property :id
    property :api_id
    property :timestamp
    property :nonce
    property :success
    property :request
    property :response

    Request  = Class.new(Hashery::OpenCascade)
    Response = Class.new(Hashery::OpenCascade)
    
    def request
      h = self[:request] || {}
      Request[h.recursive_symbolize_keys]
    end
    
    def response
      h = self[:response] || {}
      Response[h.recursive_symbolize_keys]
    end
    
    def successful?
      response.result.status_code.to_s == '200'
    end
    
    def errors
      (response.result.errors || []).map {|e| Hashery::OpenCascade[e.recursive_symbolize_keys]}
    end
    
  end
end
