module Chargify2
  class ProductResource < Resource

    def self.path
      'products'
    end

    def self.representation
      Product
    end

  end
end
