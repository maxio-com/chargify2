module Chargify2
  class Direct
    attr_reader :client
    
    def initialize(client)
      @client = client
    end
    
    def secure_parameters(params = {})
      @secure_parameters ||= default_secure_parameters
      unless params.empty?
        @secure_parameters.replace(default_secure_parameters.merge(params))
        return self
      end
      @secure_parameters
    end
    
    def to_form_inputs
      output = []
      output << %{<input type="hidden" name="secure[api_id]" value="#{h(api_id)}"/>}
      output << %{<input type="hidden" name="secure[timestamp]" value="#{h(timestamp)}"/>} if timestamp?
      output << %{<input type="hidden" name="secure[nonce]" value="#{h(nonce)}"/>} if nonce?
      output << %{<input type="hidden" name="secure[data]" value="#{h(encoded_data)}"/>} if data?
      output << %{<input type="hidden" name="secure[signature]" value="#{h(signature)}"/>}
      output.join("\n")
    end
    
    %w(api_id timestamp nonce data).each do |method|
      define_method(method) do
        secure_parameters[method.to_sym] || secure_parameters[method.to_s]
      end
      
      define_method("#{method}?") do
        value = self.send(method)
        value && value.to_s.strip.length > 0
      end
    end
    
    def encoded_data
      Rack::Utils.build_nested_query(data? ? data : {})
    end
    
    def signature
      message = "#{api_id}#{timestamp}#{nonce}#{encoded_data}"
      puts "MESSAGE: #{message}"
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), client.api_secret.to_s, message)
    end
    
    def response(params = nil)
      if params
      end
    end
    
    private
    
    def h(s)
      Rack::Utils.escape_html(s)
    end
    
    private
    
    def default_secure_parameters
      {
        :api_id => client.api_id,
      }
    end
  end
end