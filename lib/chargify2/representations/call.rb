module Chargify2
  class Call < Representation
    def successful?
      code = response.meta.status_code.to_i 
      code >= 200 && code < 300
    end

    def errors
      @errors ||= begin
        (response.meta[:errors] || []).map {|e| Hashie::Mash.new(e) }
      end
    end

  end
end
