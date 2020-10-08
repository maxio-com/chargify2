module Chargify2
  class Subscription::CancellationDataResource < Resource

    def self.path
      'subscriptions/:subscription_id/cancellation_data'
    end

    def self.representation
      Subscription::CancellationData
    end

    def self.list(query = {}, options = {})
      assembled_path = assemble_path(query)
      options.merge!(:query => query.empty? ? nil : query)
      get("/#{assembled_path}", options)
    end
  end
end