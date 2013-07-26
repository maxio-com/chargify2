module Chargify2
  class Product < Representation
    def product_family
      @product_family ||= ProductFamily.new(self[:product_family] || {})
    end
  end
end

