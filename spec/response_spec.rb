require 'spec_helper'

describe Chargify2::Response do

  describe "a new instance" do
    it "defaults to an empty hash if meta is nil" do
      response = described_class.new(Object.new, nil)
      expect(response.meta).to eql({})
    end

    it "symbolizes the meta hash's keys" do
      meta = { 'status_code' => 200, 'errors' => []}
      response = described_class.new(Object.new, meta)
      expect(response.meta[:status_code]).to eql 200
      expect(response.status_code).to eql 200
    end

    it "sets the status_code based on the meta hash" do
      meta = { status_code: 200, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.status_code).to eql 200
    end

    it "sets the errors array based on the meta hash" do
      meta = { status_code: 200, errors: ['hot diggity dogg']}
      response = described_class.new(Object.new, meta)
      expect(response.errors).to eql ['hot diggity dogg']
    end

    it "initializes an empty errors array if the meta hash does not contain errors" do
      meta = { status_code: 200 }
      response = described_class.new(Object.new, meta)
      expect(response.errors).to eql []
    end
  end

  describe "#successful" do
    it "returns true when the status code is 200" do
      meta = { status_code: 200, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.successful?).to be_true
    end

    it "returns false when the status code is not 200" do
      meta = { status_code: 422, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.successful?).to be_false
    end
  end

  describe "errors?" do
    it "returns true if the errors array contains errors" do
      meta = { status_code: 200, errors: ['hot diggity dogg']}
      response = described_class.new(Object.new, meta)
      expect(response.errors?).to be_true
    end

    it "returns false if the errors array is empty" do
      meta = { status_code: 200, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.errors?).to be_false
    end
  end

  describe "#total_count" do
    it "returns the total_count from the meta hash if found" do
      meta = { total_count: 10, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.total_count).to be(10)
    end

    it "returns 0 if total_count is nil" do
      meta = { total_count: nil, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.total_count).to be(0)
    end
  end

  describe "#current_page" do
    it "returns the current_page from the meta hash if found" do
      meta = { current_page: 99, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.current_page).to be(99)
    end

    it "returns 0 if current_page is nil" do
      meta = { current_page: nil, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.current_page).to be(0)
    end
  end

  describe "#total_pages" do
    it "returns the total_pages from the meta hash if found" do
      meta = { total_pages: 191, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.total_pages).to be(191)
    end

    it "returns 0 if total_pages is nil" do
      meta = { total_pages: nil, errors: []}
      response = described_class.new(Object.new, meta)
      expect(response.total_pages).to be(0)
    end
  end
end
