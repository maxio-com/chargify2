require 'chargify2/client'

module Chargify2
  # Resource orchestrates the connection from the Client to the Chargify API Resources, available
  # at the Resource URIs.
  #
  # Resource implements CRUD operations on the Chargify API Resources: {Resource.create}, {Resource.read},
  # {Resource.update}, {Resource.delete}, and {Resource.list}.
  class Resource
    include HTTParty

    class << self
      extend Forwardable
      def_delegators :@representation, :singular_name, :plural_name
    end

    base_uri Chargify2::Client::BASE_URI
    # headers 'Content-Type' => 'application/json', 'Accept' => 'application/json'
    format :json

    class << self
      attr_accessor :representation_name
    end

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
      uri = interpolate_uri(query)

      response = self.post(uri, :body => { :site => query })

      if response.code.to_s =~ /^2/ && resource = response.parsed_response.delete(self.singular_name)
        self.representation.new(resource)
      else
        false
      end
    end

    def create(query)
      self.class.create(query)
    end

    def self.update(id, query)
      uri = interpolate_uri(query)

      response = self.put("#{uri}/#{id}", :body => { self.singular_name => query })

      if response.code.to_s =~ /^2/ && resource = response.parsed_response.delete(self.singular_name)
        self.representation.new(resource)
      else
        false
      end
    end

    def update(id, query)
      self.class.update(id, query)
    end

    def self.list(query = {})
      response = self.get(uri, :query => query.empty? ? nil : query)

      if response.code.to_s =~ /^2/ && resources = response.parsed_response.delete(self.plural_name)
        resources.inject([]) do |responses, response_hash|
          responses << self.representation.new(response_hash.deep_symbolize_keys)
          responses
        end
      else
        []
      end
    end

    def list(query = {})
      self.class.list(query)
    end

    def self.read(id, query = {})
      uri = interpolate_uri(query)

      response = self.get("#{uri}/#{id}", :query => query.empty? ? nil : query)

      if response.code.to_s =~ /^2/ && resource = response.parsed_response.delete(self.singular_name)
        representation.new(resource)
      else
        nil
      end
    end

    def read(id, query = {})
      self.class.read(id, query)
    end

    def self.destroy(id, query = {})
      response = self.delete("#{uri}/#{id}", :query => query.empty? ? nil :query)

      if response.code.to_s =~ /^2/
        true
      else
        false
      end
    end

    def destroy(id, query = {})
      self.class.destroy(id, query)
    end

    protected
    def self.interpolate_uri(query)
      self.uri.gsub(/:([a-z|_]+)/i) { |key| query.delete($1.to_sym) }
    end
  end

  class ResourceError < StandardError; end
end
