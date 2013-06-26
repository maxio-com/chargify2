module Chargify2
  class Representation < Hashie::Trash
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
      (response.result.errors || []).map {|e| OpenCascade.new(e.symbolize_keys)}
    end
    
    class Request < Hashery::OpenCascade; end
    class Response < Hashery::OpenCascade; end
  end
end
