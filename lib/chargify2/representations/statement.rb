module Chargify2
  class Statement < Representation

    # Overridden because this is a method on the Hash class
    def index
      self[:index]
    end

    def subscription
      @subscription ||= Subscription.new((self[:subscription] || {}))
    end

    def customer
      @customer ||= Customer.new((self[:customer] || {}))
    end

    def invoice
      @invoice ||= Invoice.new((self[:invoice] || {}))
    end

    def transactions
      @transactions ||= begin
       (self[:transactions] || {}).map{|t| Transaction.new(t) }
      end
    end

    def events
      @events ||= begin
       (self[:events] || {}).map{|e| Event.new(e) }
      end
    end
  end
end
