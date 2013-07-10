module Chargify2
  class CustomerResource < Resource

    def self.path
      'customers'
    end

    def self.representation
      Customer
    end

  end
end

