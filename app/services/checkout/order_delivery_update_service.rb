# frozen_string_literal: true

module Checkout
  class OrderDeliveryUpdateService < BaseService
    def initialize(params)
      super
      @delivery_params = params[:order_params]
      @order = params[:order]
    end

    def call
      @order.delivery_type = DeliveryType.find_by(id: @delivery_params[:delivery_id])
      @order.payment_step!
    end
  end
end
