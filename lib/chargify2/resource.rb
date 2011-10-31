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

    class << self; attr_accessor :representation_name; end

    def self.path(resource_path)
      @path = resource_path
    end

    def self.uri
      if @path.nil? || @path.to_s.size == 0
        raise ResourceError, "No path configured.  Please use a defined Resource."
      end

      "#{base_uri}/#{@path}"
    end

    def uri
      self.class.uri
    end

    # Define the representation class for this resource
    def self.representation(klass = nil)
      unless klass.nil?
        @representation = klass
        @representation_name = klass.to_s.downcase.split('::').last
      end

      @representation ||= nil
    end

    def initialize(client)
      @client = client
      @username = client.api_id
      @password = client.api_password

      self.class.base_uri(client.base_uri)
      self.class.basic_auth(@username, @password)
    end

    def self.create(query)
      response = self.post(uri, :query => { :site => query })

      resource = if response.code.to_s =~ /^2/
                   self.representation.new(response.parsed_response[self.representation_name])
                 else
                   false
                 end

      resource
    end

    def create(query)
      self.class.create(query)
    end

    def self.update(id, query)
      response = self.put("#{uri}/#{id}", :query => { :site => query })

      resource = if response.code.to_s =~ /^2/
                   self.representation.new(response.parsed_response[self.representation_name])
                 else
                   false
                 end
      resource
    end

    def update(id, query)
      self.class.update(id, query)
    end

    def self.list(query = {})
      response = self.get(uri, :query => query.empty? ? nil : query)

      resources = if response.code.to_s =~ /^2/
                    response.parsed_response.inject([]) do |responses, response_hash|
                      responses << self.representation.new(response_hash[self.representation_name].symbolize_keys)
                      responses
                    end
                  else
                    []
                  end

      resources
    end

    def list(query = {})
      self.class.list(query)
    end

    def self.read(id, query = {})
      response = self.get("#{uri}/#{id}", :query => query.empty? ? nil : query)

      resource = if response.code.to_s =~ /^2/
                   response_hash = response[self.representation_name] || {}
                   representation.new(response_hash.symbolize_keys)
                 else
                   nil
                 end

      resource
    end

    def read(id, query = {})
      self.class.read(id, query)
    end
  end

  class ResourceError < StandardError; end
end
