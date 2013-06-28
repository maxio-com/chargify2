require "spec_helper"

describe Chargify2::Call do
  let(:call) { described_class.new(raw_response) }

  describe "#request" do
    it "creates a LastRequest object when initialized" do
      expect(call.request).to be_a(Chargify2::Call::LastRequest)
    end

    it "parses the request into hashery syntax" do
      expect(call.request.secure.nonce.to_s).to eql('836db4cb3137b6ece84e5481b377085a')
    end
  end

  describe "#response" do
    it "creates a LastResponse object when initialized" do
      expect(call.response).to be_a(Chargify2::Call::LastResponse)
    end

    it "parses the response into hashery syntax" do
      expect(call.response.meta.status_code.to_s).to eql('422')
    end
  end


  describe "#successful?" do
    it "is true when success is 200" do
      call = described_class.new(raw_response(status_code: 200))
      expect(call.successful?).to be_true
    end

    it "is false when success is not 200" do
      call[:success] = false
      expect(call.successful?).to be_false
    end
  end

  describe "#errors" do
    it "returns the errors in the response" do
      error = call.errors.first
      expect(error.message).to eql("Credit card number: must be a valid credit card number.")
      expect(error.attribute).to eql("full_number")
    end
  end

  private
  def raw_response(overrides={})
    errors = overrides.fetch(:errors) { [{"attribute"=>"full_number", "message"=> "Credit card number: must be a valid credit card number."}] }
    {"id"=>"e236bb664f956825cf8c094fabaac99849785874",
      "api_id"=>"8ee0d280-c183-0130-5a16-040cced33b30",
      "timestamp"=>nil,
      "nonce"=>"836db4cb3137b6ece84e5481b377085a",
      "request"=>
    {"secure"=>
      {"api_id"=>"8ee0d280-c183-0130-5a16-040cced33b30",
        "nonce"=>"836db4cb3137b6ece84e5481b377085a",
        "data"=>
      "redirect_uri=http%3A%2F%2Flvh.me%3A3001%2Fsubscriptions%2F1430%2Fcredit_cards%2F1399%2Fverify&subscription_id=1430",
        "signature"=>"2286defa70a262d6373164b6f5b76b9e191e6160"},
        "payment_profile"=>
      {"first_name"=>"{}",
        "last_name"=>"{}",
        "card_number"=>"",
        "expiration_month"=>"",
        "expiration_year"=>""},
        "id"=>"1430"},
        "response"=>
      {"result"=>
        {"status_code"=>overrides.fetch(:status_code){422},
          "result_code"=>4220,
          "errors"=>
        [{"attribute"=>"full_number",
          "message"=>
        "Credit card number: must be a valid credit card number."}]},
          "meta"=>
        {"status_code"=>overrides.fetch(:status_code){422},
          "result_code"=>4220,
          "errors"=> errors
        },
          "subscriptioncardupdater"=>
        {"payment_profile"=>
          {"billing_address"=>"",
            "billing_address_2"=>"",
            "billing_city"=>"",
            "billing_country"=>"",
            "billing_state"=>"",
            "billing_zip"=>"",
            "card_type"=>nil,
            "current_vault"=>"bogus",
            "customer_id"=>1422,
            "customer_vault_token"=>nil,
            "expiration_month"=>1,
            "expiration_year"=>2013,
            "first_name"=>"{}",
            "id"=>1399,
            "last_name"=>"{}",
            "masked_card_number"=>"XXXX-XXXX-XXXX-1",
            "vault_token"=>"1"}}},
            "success"=>nil}
  end
end
