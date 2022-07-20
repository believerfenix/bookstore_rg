# frozen_string_literal: true

module Cart
  class UpdateCartService < BaseService
    attr_reader :errors, :success_message

    def initialize(params)
      super
      @order_params = params[:order_params]
      @order = params[:order]
    end

    def call
      @service = update_cart
      return unless @service

      transfer_result
    end

    private

    def transfer_result
      @success_message = @service.success_message
      @errors = @service.errors
    end

    def update_cart
      return update_order_items if @order_params[:order_item]
      return update_coupon if @order_params[:coupon]
    end

    def update_order_items
      Cart::UpdateOrderItemService.call(order_item_params: @order_params[:order_item], order: @order)
    end

    def update_coupon
      Cart::AddCouponService.call(coupon: @order_params[:coupon], order: @order)
    end
  end
end
