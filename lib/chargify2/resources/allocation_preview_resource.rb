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

    def self.create(body, options = {})
      assembled_path = assemble_path(options)
      options.merge!(:body => { allocations: body }.to_json)
      response = post("/#{assembled_path}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.send('billing_manifest') || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end
  end
end


