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
      LastRequest[recursive_symbolize_keys(input)]
    end

    def response
      input = self[:response] || {}
      LastResponse[recursive_symbolize_keys(input)]
    end

    def successful?
      response.meta.status_code.to_s == '200'
    end

    def errors
      (response.meta.errors || []).map {|e| Hashery::OpenCascade[recursive_symbolize_keys(e)]}
    end

    class LastRequest < Hashery::OpenCascade; end
    class LastResponse < Hashery::OpenCascade; end
  end
end
