module Chargify2
  module Utils
    def self.deep_symbolize_keys(hash)
      hash = hash || {}
      hash.inject(Hashie::Mash.new({})){|result, (key, value)|
        new_key = case key
                  when String then key.to_sym
                  else key
                  end
        new_value = case value
                    when Hash then Hashie::Mash.new(deep_symbolize_keys(value))
                    else value
                    end
        result[new_key] = new_value
        result
      }
    end
  end
end
