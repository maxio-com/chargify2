require 'spec_helper'

describe Chargify2::Utils do

  describe "#sanitize_response" do
    let(:sanitized_response) do
      described_class.sanitize_response([{ kylo:  "<script>alert(1)</script>", ren:   { ben: "<script>alert('solo')</script>"    } },
                                         { darth: "<script>alert(2)</script>", vader: { ani: "<script>alert('sky guy')</script>" } }])
    end

    it "sanitizes the response" do
      expect(sanitized_response.first[:kylo]).to eql("")
    end

    it "deeply sanitizes the response" do
      expect(sanitized_response.first[:ren][:ben]).to eql("")
    end

    it "sanitizes multiple items" do
      expect(sanitized_response.last[:darth]).to eql("")
    end
  end
end
