module Chargify2
  class ReasonCodes < Representation
    def reason_codes
      @reason_codes ||= begin
        (self[:reason_codes] || {}).map{|rc| ReasonCode.new(rc) }
      end
    end
  end
end
