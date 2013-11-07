require 'chargify2/client'
require 'json'

module Chargify2
  # Resource orchestrates the connection from the Client to the Chargify API Resources, available
  # at the Resource URIs.
  #
  # Resource implements CRUD operations on the Chargify API Resources: {Resource.create}, {Resource.read},
  # {Resource.update}, {Resource.delete}, and {Resource.list}.
  ResourceError = Class.new(StandardError)

  class Resource
    include HTTParty

    base_uri Chargify2::Client::BASE_URI
    headers 'Content-Type' => 'application/json', 'Accept' => 'application/json'
    format :json

    def initialize(client)
      @client   = client
      @base_uri = client.base_uri
      @auth     = {:username => client.api_id, :password => client.api_password}
    end

    def read(id, query = {}, options = {})
      self.class.read(id, query, merge_options(options))
    end

    def self.read(id, query = {}, options = {})
      assembled_path = assemble_path(query)
      options.merge!(:query => query.empty? ? nil : query)
      response = get("/#{assembled_path}/#{id}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.send(representation.to_s.downcase.split('::').last) || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end

    def list(query = {}, options = {})
      self.class.list(query, merge_options(options))
    end

    def self.list(query = {}, options = {})
      assembled_path = assemble_path(query)
      options.merge!(:query => query.empty? ? nil : query)
      response = get("/#{assembled_path}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.send(plural_name) || {}

      self.create_response(
        response_hash.map{|resource| representation.new(resource)},
        response.meta
      )
    end

    def create(body, options = {})
      self.class.create(body, merge_options(options))
    end

    def self.create(body, options = {})
      assembled_path = assemble_path(query)
      options.merge!(:body => { singular_name.to_sym => body}.to_json)
      response = post("/#{assembled_path}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.send(singular_name) || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end

    def update(id, body, options = {})
      self.class.update(id, body, merge_options(options))
    end

    def self.update(id, body, options = {})
      assembled_path = assemble_path(body)
      options.merge!(:body => { singular_name.to_sym => body}.to_json)
      response = put("/#{assembled_path}/#{id}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.send(singular_name) || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end

    def destroy(id, body = {}, options = {})
      self.class.destroy(id, body, merge_options(options))
    end

    def self.destroy(id, body = {}, options = {})
      assembled_path = assemble_path(body)
      options.merge!(:body => { singular_name.to_sym => body}.to_json)
      response = delete("/#{assembled_path}/#{id}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.send(singular_name) || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end

    def self.create_response(resource, meta_data)
      Response.new(resource, meta_data)
    end

    def self.assemble_path(params)
      new_path = path.dup
      params.each do |key, value|
        if new_path.include?(":#{key}")
          new_path.gsub!(":#{key}", value.to_s)
          params.delete(key)
        end
      end
      new_path
    end

    def self.singular_name
      Utils.underscore(representation.to_s).split('::').last
    end

    def self.plural_name
      singular_name + "s"
    end

    private

    def merge_options(options)
      if @base_uri
        options.merge!(:base_uri => @base_uri)
      end

      if @auth
        options.merge!(:basic_auth => @auth)
      end
      options
    end
  end
end
