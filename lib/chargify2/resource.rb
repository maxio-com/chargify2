module Chargify2
  class Resource
    include HTTParty

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
    
    def initialize(client)
      @client = client
      @username = client.api_id
      @password = client.api_password
      
      self.class.base_uri(client.base_uri)
      self.class.basic_auth(@username, @password)
    end
    
    def self.read(id, query = {})
      response = get("#{uri}/#{id}", :query => query.empty? ? nil : query)
      Chargify2::Call.new(response['call'].symbolize_keys)
    end
    
    def read(id, query = {})
      self.class.read(id, query)
    end
  end
  
  class ResourceError < StandardError; end
end