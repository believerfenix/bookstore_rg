# frozen_string_literal: true

module Checkout
  class OrderCardUpdateService < BaseService
    def initialize(params)
      super
      @card_params = params[:order_params][:card]
      @order = params[:order]
    end

    def call
      card_form = CardForm.new(@card_params)
      @errors << card_form.errors.full_messages unless card_form.save(@order)

      @order.confirm_step! if success?
    end
  end
end
