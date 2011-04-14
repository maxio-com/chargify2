module Chargify2
  module Utils
    module HashExtensions
      # Symbolizes keys for flat or nested hashes (operates recursively on nested hashes)
      def symbolize_keys
        Hash[
          self.map { |key, value|
            k = key.to_sym
            v = value.is_a?(Hash) ? value.symbolize_keys : value
            [k,v]
          }
        ]
      end
    end
  end
end