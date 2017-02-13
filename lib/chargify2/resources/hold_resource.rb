module Chargify2
  class HoldResource < Resource
    def self.path
      "subscriptions/:subscription_id/hold"
    end

    def self.representation
      Hold
    end
  end
end
