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

    # From: https://raw.github.com/rails/rails/feaa6e2048fe86bcf07e967d6e47b865e42e055b/activesupport/lib/active_support/inflector/methods.rb
    def self.underscore(camel_cased_word)
      word = camel_cased_word.to_s.dup
      # word.gsub!('::', '/')
      # Not using inflectors because we don't want to load active_support
      #word.gsub!(/(?:([A-Za-z\d])|^)(#{inflections.acronym_regex})(?=\b|[^a-z])/) { "#{$1}#{$1 && '_'}#{$2.downcase}" }
      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end
  end
end
