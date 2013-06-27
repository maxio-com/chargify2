module Chargify2
  class Call < Representation
    property :id
    property :api_id
    property :timestamp
    property :nonce
    property :success
    property :request
    property :response

    def request
      LastRequest[self[:request] || {}]
    end

    def response
      LastResponse[self[:response] || {}]
    end

    def successful?
      #TODO: get this workign with hashie syntax
      response['meta']['status_code'].to_s == '200'
    end

    def errors
      #TODO: get this workign with hashie syntax
      (response['meta']['errors'] || []).map {|e| Hashery::OpenCascade[e.symbolize_keys]}
    end

    class LastRequest < Hashery::OpenCascade; end
    class LastResponse < Hashery::OpenCascade; end
  end
end
