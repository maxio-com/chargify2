module Chargify2
  class AllocationPreviewResource < Resource
    def self.path
      'subscriptions/:subscription_id/allocations/preview'
    end

    def self.representation
      BillingManifest
    end

    # singular and plural name are the same due to bulk
    # updates.

    def self.singular_name
      'allocations'
    end

    def self.plural_name
      'allocations'
    end
  end
end


