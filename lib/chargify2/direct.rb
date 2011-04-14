module Chargify2
  class Direct
    attr_reader :client
    
    def initialize(client)
      @client = client
    end
    
    def secure_parameters(params = {})
      SecureParameters.new(params, client)
    end

    def result(params = {})
      Result.new(params, client)
    end

    def self.signature(message, secret)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret, message)
    end
        
    class SecureParameters
      attr_reader :api_id
      attr_reader :timestamp
      attr_reader :nonce
      attr_reader :data
      attr_reader :secret
      
      def initialize(hash, client)
        args = hash.symbolize_keys
        
        @api_id     = client.api_id
        @timestamp  = args[:timestamp]
        @nonce      = args[:nonce]
        @data       = args[:data]
        @secret     = client.api_secret
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

      %w(timestamp nonce data).each do |method|
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
        Direct.signature(message, secret)
      end
      
      private
      
      def h(s)
        Rack::Utils.escape_html(s)
      end
      
    end
    
    class Result
      attr_reader :api_id
      attr_reader :status_code
      attr_reader :result_code
      attr_reader :call_id
      attr_reader :secret
      
      def initialize(params, client)
        args = params.symbolize_keys
        
        @api_id       = client.api_id
        @status_code  = args[:status_code]
        @result_code  = args[:result_code]
        @call_id      = args[:call_id]
        @secret       = client.api_secret
      end
      
      def verified?
        message = "#{api_id}#{status_code}#{result_code}#{call_id}"
        Direct.signature(message, secret)
      end
      
      def success?
        status_code.to_s == '200'
      end
    end
  end
end