module Chargify2
  class SubscriptionsComponentResource < Resource

    def self.path
      "subscriptions/:subscription_id/components"
    end

    def self.representation
      SubscriptionsComponent
    end

  end
end
