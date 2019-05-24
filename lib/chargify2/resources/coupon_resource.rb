module Chargify2
  class CouponResource < Resource

    def self.path
      'subscriptions/:subscription_id/coupons'
    end

    def self.representation
      Coupon
    end

    def self.create(body, options = {})
      assembled_path = assemble_path(options)
      options.merge!(:body => { coupons: body }.to_json)
      response = post("/#{assembled_path}", options)
      response = Chargify2::Utils.deep_symbolize_keys(response.to_h)
      response_hash = response.coupons || {}

      self.create_response(
        response_hash.map{|resource| representation.new(resource)},
        response.meta
      )
    end
  end
end
