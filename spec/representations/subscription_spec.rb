require "spec_helper"

describe Chargify2::Subscription do
  let(:subscription) { described_class.new(raw_response) }

  it "allows access to id property" do
    expect(subscription.id).to eql(1430)
  end

  describe "#customer" do
    it "is a Chargify2::Customer object" do
      expect(subscription.customer).to be_a(Chargify2::Customer)
      expect(subscription.customer.id).to eql(1422)
    end
  end

  describe "#product" do
    it "is a Chargify2::Product object" do
      expect(subscription.product).to be_a(Chargify2::Product)
      expect(subscription.product.id).to eql(41)
    end
  end

  describe "#credit_card" do
    it "is a Chargify2::CreditCard object" do
      expect(subscription.credit_card).to be_a(Chargify2::CreditCard)
      expect(subscription.credit_card.id).to eql(1399)
    end

    it "allows for a missing credit card" do
      response = raw_response
      response.delete("credit_card")
      subscription = described_class.new(response)
      expect(subscription.credit_card.first_name).to be_nil
    end
  end

  private

  def raw_response(overrides={})
    {
      "id"=>1430,
      "state"=>"canceled",
      "balance_in_cents"=>0,
      "current_period_started_at"=>"2013-06-11T09:23:53-04:00",
      "current_period_ends_at"=>"2013-07-11T09:23:53-04:00",
      "next_assessment_at"=>"2013-07-11T09:23:53-04:00",
      "trial_started_at"=>nil,
      "trial_ended_at"=>nil,
      "activated_at"=>"2013-06-11T09:23:56-04:00",
      "expires_at"=>nil,
      "created_at"=>"2013-06-11T09:23:53-04:00",
      "updated_at"=>"2013-06-27T18:00:54-04:00",
      "customer"=> {
        "address"=>"",
        "address_2"=>"",
        "city"=>"",
        "country"=>"",
        "created_at"=>"2013-06-11T09:23:35-04:00",
        "email"=>"foo@bar.com",
        "first_name"=>"John",
        "id"=>1422,
        "last_name"=>"Doe",
        "organization"=>"",
        "phone"=>"",
        "reference"=>nil,
        "state"=>"",
        "updated_at"=>"2013-06-20T09:24:29-04:00",
        "zip"=>""
       },
      "product"=> {
        "accounting_code"=>"",
        "archived_at"=>nil,
        "created_at"=>"2013-06-11T09:23:18-04:00",
        "description"=>"asdfdsaf",
        "expiration_interval"=>nil,
        "expiration_interval_unit"=>"never",
        "handle"=>"fasdf",
        "id"=>41,
        "initial_charge_in_cents"=>nil,
        "interval"=>1,
        "interval_unit"=>"month",
        "name"=>"Basic",
        "price_in_cents"=>1100,
        "request_credit_card"=>true,
        "require_credit_card"=>true,
        "return_params"=>"",
        "return_url"=>"",
        "trial_interval"=>nil,
        "trial_interval_unit"=>"month",
        "trial_price_in_cents"=>nil,
        "update_return_url"=>"",
        "updated_at"=>"2013-06-11T09:23:18-04:00",
        "product_family_name" => "Basic Plan",
       },
      "credit_card"=> {
        "billing_address"=>"",
        "billing_address_2"=>"",
        "billing_city"=>"",
        "billing_country"=>"",
        "billing_state"=>"",
        "billing_zip"=>"",
        "card_type"=>"bogus",
        "current_vault"=>"bogus",
        "customer_id"=>1422,
        "customer_vault_token"=>nil,
        "expiration_month"=>1,
        "expiration_year"=>2013,
        "first_name"=>"Foo",
        "id"=>1399,
        "last_name"=>"Bar",
        "masked_card_number"=>"XXXX-XXXX-XXXX-1",
        "vault_token"=>"1"
      },
      "cancellation_message"=>"",
      "canceled_at"=>"2013-06-12T11:37:10-04:00",
      "signup_revenue"=>"11.00",
      "signup_payment_id"=>3916,
      "delayed_cancel_at"=>nil,
      "previous_state"=>"canceled",
      "coupon_code"=>nil,
      "cancel_at_end_of_period"=>false,
      "payment_collection_method"=>"automatic"
    }
  end
end

