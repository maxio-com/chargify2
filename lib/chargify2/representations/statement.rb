module Chargify2
  class Statement < Representation
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
