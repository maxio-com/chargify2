module Chargify2
  class TransactionResource < Resource
    path 'transactions'
    representation Transaction
  end
end

