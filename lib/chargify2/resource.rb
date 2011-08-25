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
        @@representation = klass
      end
      @@representation ||= nil
    end
    
    def initialize(client)
      @client = client
      @username = client.api_id
      @password = client.api_password
      
      self.class.base_uri(client.base_uri)
      self.class.basic_auth(@username, @password)
    end
    
    def self.read(id, query = {})
      response = get("#{uri}/#{id}", :query => query.empty? ? nil : query)
      response_hash = response[representation.to_s.downcase.split('::').last] || {}
      representation.new(response_hash.symbolize_keys)
    end
    
    def read(id, query = {})
      self.class.read(id, query)
    end
  end
  
  class ResourceError < StandardError; end
end