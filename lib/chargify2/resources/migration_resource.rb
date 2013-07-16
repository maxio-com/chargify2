module Chargify2
  class MigrationResource < Resource

    def self.path
      'migrations'
    end

    def self.representation
      Migration
    end

    def preview(subscription_id, product_id, options = {})
      self.class.preview(subscription_id, product_id, merge_options(options))
    end

    def self.preview(subscription_id, product_id, options = {})
      options.merge!(body: { subscription_id: subscription_id, product_id: product_id }.to_json)
      response = post("/#{path}/preview", options)
      response_hash = response[representation.to_s.downcase.split('::').last] || {}

      self.create_response(
        representation.new(response_hash.symbolize_keys),
        response['meta']
      )
    end
  end
end

