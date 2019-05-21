module Chargify2
  class MigrationResource < Resource
    def self.path
      'migrations'
    end

    def self.representation
      Migration
    end

    def preview(migration_params, options = {})
      self.class.preview(migration_params, merge_options(options))
    end

    def self.preview(migration_params, options = {})
      options.merge!(body: { migration: migration_params }.to_json)
      response = post("/#{path}/preview", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response[representation.to_s.downcase.split('::').last] || {}

      create_response(
        representation.new(response_hash),
        response['meta']
      )
    end
  end
end
