module Chargify2
  class AllocationPreviewResource < Resource
    def self.path
      'subscriptions/:subscription_id/allocations/preview'
    end

    def self.representation
      BillingManifest
    end
  end
end


