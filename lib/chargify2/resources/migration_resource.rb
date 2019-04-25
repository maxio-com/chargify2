module Chargify2
  class MigrationResource < Resource

    def self.path
      'migrations'
    end

    def self.representation
      Migration
    end

    def preview(subscription_id, plan_attrs = {}, options = {})
      self.class.preview(subscription_id, plan_attrs, merge_options(options))
    end

    def self.preview(subscription_id, plan_attrs, options = {})
      options.merge!(body: { migration: { subscription_id: subscription_id }.merge!(plan_attrs) }.to_json)
      response = post("/#{path}/preview", options)
      response_hash = response[representation.to_s.downcase.split('::').last] || {}

      self.create_response(
        representation.new(response_hash.symbolize_keys),
        response['meta']
      )
    end
  end
end
