module Chargify2
  class Customer < Representation
    
    # Overridden because this is a method on the Hash class
    def zip
      self[:zip]
    end
  end
end

