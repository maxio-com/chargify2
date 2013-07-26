module Chargify2
  class Migration < Representation
    def billing_manifest
      @billing_manifest ||= BillingManifest.new(self[:billing_manifest] || {})
    end
  end
end
