module Chargify2
  module Utils
    module HashExtensions
      # Symbolizes keys for flat or nested hashes (operates recursively on nested hashes)
      def deep_symbolize_keys
        Hash[
          self.map { |key, value|
            return if key.nil?

            k = key.to_sym
            v = value.is_a?(Hash) ? value.deep_symbolize_keys : value
            [k,v]
          }
        ]
      end
    end
  end
end
