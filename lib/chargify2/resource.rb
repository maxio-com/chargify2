module Chargify2
  class Resource
    def self.relative_uri(str = nil)
      unless str.nil?
        @relative_uri = str
      end
      @relative_uri
    end
  
    relative_uri 'resources'

    def self.base_uri
      if client.nil?
        raise ClientConnectionError, "No client connected."
      end
      client.base_uri
    end
  
    def self.uri
      "#{base_uri}/#{@relative_uri}"
    end
  
    def self.client=(client)
      @@client = client
    end
  
    def self.client
      @@client
    end
  
    def self.read(id, query = {})
      request_args = {}
      request_headers = headers.merge(:params => query)
      RestClient.get "#{uri}/#{id}", request_headers
    end
    
    private
    
    def self.headers
      {:user => client.api_id, :password => client.api_password, :accept => 'application/json', :content_type => 'application/json'}
    end
    
    def symbolize_keys(arg)
      case arg
      when Array
        arg.map { |elem| symbolize_keys elem }
      when Hash
        Hash[
          arg.map { |key, value|  
            k = key.is_a?(String) ? key.to_sym : key
            v = symbolize_keys value
            [k,v]
          }]
      else
        arg
      end
    end
  end
end