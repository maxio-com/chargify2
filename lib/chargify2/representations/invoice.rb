module Chargify2
  class Invoice < Representation
    def transactions
      @transactions ||= begin
       (self[:transactions] || {}).map{|t| Transaction.new(t) }
      end
    end
  end
end
