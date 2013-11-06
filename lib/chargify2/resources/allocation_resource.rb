module Chargify2
  class AllocationResource < Resource

    def self.path
      'subscriptions/:subscription_id/allocations'
    end

    def self.representation
      Allocation
    end

  end
end

