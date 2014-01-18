require "spec_helper"

module Chargify2
  describe RenewalPreviewResource do
    it "has the correct path" do
      expect(described_class.path).to eql('subscriptions/:subscription_id/renewals/preview')
    end

    it "represents the RenewalPreview resource" do
      expect(described_class.representation).to eql(RenewalPreview)
    end
  end
end


