module Chargify2
  class ReasonCodeResource < Resource

    def self.path
      'reason_codes'
    end

    def self.representation
      ReasonCodes
    end

  end
end
