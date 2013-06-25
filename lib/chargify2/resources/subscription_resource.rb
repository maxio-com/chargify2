module Chargify2
  class SubscriptionResource < Resource
    path 'subscriptions'
    representation Subscription
  end
end

