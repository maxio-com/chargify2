module Chargify2
  class CreditCard < Representation
    property :id
    property :first_name
    property :last_name
    property :masked_card_number
    property :card_type
    property :expiration_month
    property :expiration_year
    property :billing_address
    property :billing_address_2
    property :billing_city
    property :billing_state
    property :billing_zip
    property :billing_country
    property :current_vault
    property :vault_token
    property :customer_vault_token
    property :customer_id
  end
end


