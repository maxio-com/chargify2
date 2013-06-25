require 'chargify2/client'

module Chargify2
  # Resource orchestrates the connection from the Client to the Chargify API Resources, available
  # at the Resource URIs.
  #
  # Resource implements CRUD operations on the Chargify API Resources: {Resource.create}, {Resource.read},
  # {Resource.update}, {Resource.delete}, and {Resource.list}.
  class Resource
    include HTTParty

    base_uri Chargify2::Client::BASE_URI
    headers 'Content-Type' => 'application/json', 'Accept' => 'application/json'
    format :json

    def self.path(resource_path = nil)
      return @path unless resource_path
      @path = resource_path
    end

    # Define the representation class for this resource
    def self.representation(klass = nil)
      unless klass.nil?
        @@representation = klass
      end
      @@representation ||= nil
    end

    def initialize(client)
      @client = client
      @base_uri = client.base_uri
      @auth = {:username => client.api_id, :password => client.api_password}
    end

    def self.read(id, query = {}, options = {})
      options.merge!(:query => query.empty? ? nil : query)
      response = get("/#{path}/#{id}", options)

      response_hash = response[representation.to_s.downcase.split('::').last] || {}
      representation.new(response_hash.symbolize_keys)
    end

    def read(id, query = {}, options = {})
      self.class.read(id, query, merge_options(options))
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

    def self.list(query = {})
      response = get("#{uri}", :query => query.empty? ? nil : query)
      singular_name = representation.to_s.downcase.split('::').last
      response_hash = response[singular_name + "s"] || {}
      response_hash.map{|x| representation.new(x[singular_name].symbolize_keys)}
    end

    def list(query = {})
      self.class.list(query)
    end
  end

  class ResourceError < StandardError; end
end
