require "spec_helper"

describe Chargify2::Statement do
  let(:statement) { described_class.new(raw_response) }

  it "is a Chargify2::Statement object" do
    expect(statement).to be_a(Chargify2::Statement)
  end

  it "it parses the response correctly" do
    expect(statement.id).to eql(123)
  end

  it "has access to the customer" do
    expect(statement.customer.class).to eql(Chargify2::Customer)
    expect(statement.customer.first_name).to eql("David")
  end

  it "has access to the invoice" do
    expect(statement.invoice.class).to eql(Chargify2::Invoice)
    expect(statement.invoice.display_number).to eql("000001")
  end

  it "has access to the transactions" do
    expect(statement.transactions.first.class).to eql(Chargify2::Transaction)
    expect(statement.transactions.first.kind).to eql("baseline")
  end

  private

  def raw_response
  {
    "id"=>123,
    "closed_at"=>nil,
    "ending_balance_in_cents"=>nil,
    "future_payments"=>[],
    "memo"=>"",
    "opened_at"=>nil,
    "settled_at"=>nil,
    "starting_balance_in_cents"=>nil,
    "created_at"=>"2013-07-19T15:46:51-04:00",
    "updated_at"=>"2013-07-19T15:46:51-04:00",
    "billing_address"=>nil,
    "billing_address_2"=>nil,
    "billing_city"=>nil,
    "billing_state"=>nil,
    "billing_country"=>nil,
    "billing_zip"=>nil,
    "shipping_address"=>nil,
    "shipping_address_2"=>nil,
    "shipping_city"=>nil,
    "shipping_state"=>nil,
    "shipping_country"=>nil,
    "shipping_zip"=>nil,
    "product_id" => 222,
    "product_family_name" => "I'ma",
    "product_name" =>"Pro",
    "invoice"=>
    {
      "id"=>1,
      "subscription_id"=>124,
      "statement_id"=>1,
      "site_id"=>3,
      "state"=>"paid",
      "total_amount_in_cents"=>0,
      "paid_at"=>"2013-07-19T15:46:51-04:00",
      "created_at"=>"2013-07-19T15:46:51-04:00",
      "updated_at"=>"2013-07-19T15:46:51-04:00",
      "total_amount_in_cents"=>0,
      "number"=>1,
      "display_number" => "000001",
      "transactions"=>[]
    },
    "customer" => {
      :id           => 99,
      :first_name   => "David",
      :last_name    => "Smith",
      :email        => "david.smith@example.com",
      :organization => "Org",
      :reference    => "ref",
      :address      => "addy1",
      :address_2    => "add2",
      :city         => "my city",
      :state        => "my state",
      :zip          => "my zip",
      :country      => "US of A",
      :phone        => "digits",
    },
    "events"=>[],
    "transactions"=> [
      {
        "id"=>1,
        "transaction_type"=>"charge",
        "amount_in_cents"=>0,
        "created_at"=>"2013-07-19T15:46:51-04:00",
        "starting_balance_in_cents"=>nil,
        "ending_balance_in_cents"=>nil,
        "memo"=>"memo",
        "success"=>true,
        "kind"=> "baseline",
        "subscription_id"=>125,
        "product_id"=>3,
        "payment_id"=>nil,
        "gateway_transaction_id"=>nil
      }
    ]
  }
  end
end
