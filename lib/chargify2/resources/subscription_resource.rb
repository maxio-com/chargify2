module Chargify2
  class SubscriptionResource < Resource

    def self.path
      'subscriptions'
    end

    def self.representation
      Subscription
    end

  end
end

