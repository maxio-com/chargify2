require "spec_helper"

module Chargify2
  describe SubscriptionsComponentResource do
    it "has the correct path" do
      expect(described_class.path).to eql('subscriptions/:subscription_id/components')
    end
    
    it "represents the SubscriptionsComponent resource" do
      expect(described_class.representation).to eql(SubscriptionsComponent)
    end
  end
end
