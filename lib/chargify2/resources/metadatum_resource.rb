module Chargify2
  class MetadatumResource < Resource
    def self.path
      ":resource_type/:id/metadata"
    end

    def self.representation
      Metadatum
    end

    def self.singular_name
      "metadatum"
    end

    def self.plural_name
      "metadata"
    end

    def update_all(metadata_array, options = {})
      self.class.update_all(metadata_array, merge_options(options))
    end

    def self.update_all(metadata_array, options = {})
      assembled_path = assemble_path(options)
      options.merge!(body: { metadata: metadata_array, resource_id: options[:resource_id], resource_type: options[:resource_type] }.to_json)
      response = put("/#{assembled_path}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.metadata || {}

      create_response(
        response_hash.map { |resource| representation.new(resource) },
        response.meta
      )
    end
  end
end
