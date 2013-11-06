require "spec_helper"

module Chargify2
  describe AllocationResource do
    it "has the correct path" do
      expect(described_class.path).to eql('subscriptions/:subscription_id/allocations')
    end
    
    it "represents the Allocation resource" do
      expect(described_class.representation).to eql(Allocation)
    end
  end
end

