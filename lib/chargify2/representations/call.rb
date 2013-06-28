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
      input = self[:request] || {}
      LastRequest[input.symbolize_keys]
    end

    def response
      input = self[:response] || {}
      LastResponse[input.symbolize_keys]
    end

    def successful?
      response.meta.status_code.to_s == '200'
    end

    def errors
      (response.meta.errors || []).map {|e| Hashery::OpenCascade[e.symbolize_keys]}
    end

    class LastRequest < Hashery::OpenCascade; end
    class LastResponse < Hashery::OpenCascade; end
  end
end
