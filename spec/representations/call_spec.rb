require "spec_helper"

describe Chargify2::Call do
  subject {
    described_class.new({
      "id" => 12,
      "api_id" => 34,
      "timestamp" => Time.now,
      "nonce" => "sense",
      "success" => true,
      "request" => {
        :foo => "bar",
        "zoo" => "cow",
      },
      :response => {
        "foo" => "bar",
        :zoo => "cow",
        :result => { }
      } 
    })
  }

  # Note: Rspec does weird stuff 
  # with opencascade in should comparison
  # hence the locals
  
  describe "#request" do
    it "allows dot notation method chaining" do
      foo = subject.request.foo
      zoo = subject.request.zoo

      expect(foo).to eql("bar")
      expect(zoo).to eql("cow")
    end
  end

  describe "#response" do
    it "allows dot notation method chaining" do
      foo = subject.response.foo
      zoo = subject.response.zoo

      expect(foo).to eql("bar")
      expect(zoo).to eql("cow")
    end
  end
end
