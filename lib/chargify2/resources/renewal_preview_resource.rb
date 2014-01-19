module Chargify2
  class RenewalPreviewResource < Resource

    def self.path
      'subscriptions/:subscription_id/renewals/preview'
    end

    def self.representation
      RenewalPreview
    end

  end
end


