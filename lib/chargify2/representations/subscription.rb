module Chargify2
  class Subscription < Representation

    def customer
      @customer ||= Customer.new(self[:customer] || {})
    end

    def product
      @product ||= Product.new(self[:product] || {})
    end

    def credit_card
      @credit_card ||= CreditCard.new(self[:credit_card] || {})
    end
  end
end

