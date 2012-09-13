module Chargify2
  class Direct
    attr_reader :client

    def initialize(client)
      @client = client
      validate_client
    end

    def secure_parameters(params = {})
      SecureParameters.new(params, client)
    end

    def response_parameters(params = {})
      ResponseParameters.new(params, client)
    end

    def self.signature(message, secret)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret, message)
    end

    private

    def validate_client
      unless client.is_a?(Client)
        raise ArgumentError.new("Direct.new requires a Client as an argument")
      end
    end

    # There is no need to instantiate a SecureParameters instance directly.  Use Direct#secure_parameters
    # instead.
    class SecureParameters
      attr_reader :api_id
      attr_reader :timestamp
      attr_reader :nonce
      attr_reader :data
      attr_reader :secret

      def initialize(hash, client)
        args = hash.symbolize_keys

        @api_id     = client.api_id
        @secret     = client.api_secret

        @timestamp  = args[:timestamp]
        @nonce      = args[:nonce]
        @data       = args[:data]

        validate_args
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

      %w(timestamp nonce data api_id secret).each do |method|
        define_method("#{method}?") do
          value = self.send(method)
          value && !(value.is_a?(Hash) ? value : value.to_s.strip).empty?
        end
      end

      def encoded_data
        hash = data? ? data : {}
        Rack::Utils.build_nested_query(hash)
      end

      def signature
        message = "#{api_id}#{timestamp}#{nonce}#{encoded_data}"
        Direct.signature(message, secret)
      end

      private

      def h(s)
        ERB::Util.html_escape(s)
      end

      def validate_args
        if data && !data.is_a?(Hash)
          raise ArgumentError.new("The 'data' must be provided as a Hash (you passed a #{data.class})")
        end

        unless api_id? && secret?
          raise ArgumentError.new("SecureParameters require connection to a Client - was one given?")
        end
      end
    end

    # There is no need to instantiate a ResponseParameters instance directly.  Use Direct#response_parameters instead.
    class ResponseParameters
      attr_reader :api_id
      attr_reader :timestamp
      attr_reader :nonce
      attr_reader :status_code
      attr_reader :result_code
      attr_reader :call_id
      attr_reader :secret
      attr_reader :signature

      def initialize(params, client)
        args = params.symbolize_keys

        @api_id       = client.api_id
        @secret       = client.api_secret

        @status_code  = args[:status_code]
        @timestamp    = args[:timestamp]
        @nonce        = args[:nonce]
        @result_code  = args[:result_code]
        @call_id      = args[:call_id]
        @signature    = args[:signature]

        validate_args
      end

      def verified?
        message = "#{api_id}#{timestamp}#{nonce}#{status_code}#{result_code}#{call_id}"
        Direct.signature(message, secret) == signature
      end

      def success?
        status_code.to_s == '200'
      end

      private

      def validate_args
        unless api_id && secret && api_id.to_s.length > 0 && secret.to_s.length > 0
          raise ArgumentError.new("ResponseParameters require connection to a Client - was one given?")
        end
      end
    end
  end
end
