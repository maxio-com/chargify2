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
      options.merge!(:query => query.empty? ? nil : query)
      response = get("/#{path}/#{id}", options).value
      response = Chargify2::Utils.deep_symbolize_keys(response)
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
      options.merge!(:query => query.empty? ? nil : query)
      response = get("/#{path}", options).value
      response = Chargify2::Utils.deep_symbolize_keys(response)
      singular_name = representation.to_s.downcase.split('::').last
      response_hash = response.send((singular_name + "s")) || {}

      self.create_response(
        response_hash.map{|resource| representation.new(resource)},
        response.meta
      )
    end

    def create(body, options = {})
      self.class.create(body, merge_options(options))
    end

    def self.create(body, options = {})
      singular_name = representation.to_s.downcase.split('::').last
      options.merge!(:body => { singular_name.to_sym => body}.to_json)
      response = post("/#{path}", options).value
      response = Chargify2::Utils.deep_symbolize_keys(response)
      response_hash = response.send(representation.to_s.downcase.split('::').last) || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end

    def update(id, body, options = {})
      self.class.update(id, body, merge_options(options))
    end

    def self.update(id, body, options = {})
      singular_name = representation.to_s.downcase.split('::').last
      options.merge!(:body => { singular_name.to_sym => body}.to_json)
      response = put("/#{path}/#{id}", options).value
      response = Chargify2::Utils.deep_symbolize_keys(response)
      response_hash = response.send(representation.to_s.downcase.split('::').last) || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end

    def destroy(id, body = {}, options = {})
      self.class.destroy(id, body, merge_options(options))
    end

    def self.destroy(id, body = {}, options = {})
      singular_name = representation.to_s.downcase.split('::').last
      options.merge!(:body => { singular_name.to_sym => body}.to_json)
      response = delete("/#{path}/#{id}", options).value
      response = Chargify2::Utils.deep_symbolize_keys(response)
      response_hash = response.send(representation.to_s.downcase.split('::').last) || {}

      self.create_response(
        representation.new(response_hash),
        response.meta
      )
    end

    def self.create_response(resource, meta_data)
      Response.new(resource, meta_data)
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
