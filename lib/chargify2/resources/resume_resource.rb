module Chargify2
  class ResumeResource < Resource
    def self.path
      "subscriptions/:subscription_id/resume"
    end

    def self.representation
      Resume
    end
  end
end
