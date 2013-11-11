module Chargify2
  class AllocationResource < Resource

    def self.path
      'subscriptions/:subscription_id/allocations'
    end

    def self.representation
      Allocation
    end

    def self.create(body, options = {})
      assembled_path = assemble_path(options)
      options.merge!(:body => { allocations: body }.to_json)
      response = post("/#{assembled_path}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.allocations || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end
  end
end

