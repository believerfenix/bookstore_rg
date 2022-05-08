# frozen_string_literal: true

module Cart
  class AddCouponService < BaseService
    def initialize(params)
      super
      @order = params[:order]
      @coupon_params = params[:coupon]
    end

    def call
      validate_coupon
      return unless success?

      coupon.update(active: false)
      @order.coupon = coupon
      assign_success_message('cart.coupon_added')
    end

    def validate_coupon
      @errors << I18n.t('cart.invalid_coupon') if coupon.nil?
      @errors << I18n.t('cart.coupon_used') if coupon.present? && !coupon.active?
    end

    def coupon
      @coupon ||= Coupon.find_by(code: @coupon_params[:code])
    end
  end
end
