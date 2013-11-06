require "spec_helper"

module Chargify2
  describe AllocationPreviewResource do
    it "has the correct path" do
      expect(described_class.path).to eql('subscriptions/:subscription_id/allocations/preview')
    end
    
    it "represents the BillingManifest resource" do
      expect(described_class.representation).to eql(BillingManifest)
    end
  end
end


