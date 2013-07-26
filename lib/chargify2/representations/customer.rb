module Chargify2
  class Customer < Representation
    def zip
      self[:zip]
    end
  end
end

