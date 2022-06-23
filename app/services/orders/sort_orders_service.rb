# frozen_string_literal: true

module Orders
  class SortOrdersService
    attr_reader :orders

    ORDER_DEFAULT_FILTER = :checkout_complete

    def initialize(params)
      @order_state = params[:order_state]
    end

    def call
      @order_state ? find_orders : find_checkout_finished_orders
    end

    private

    def find_orders
      return unless valid_state?

      Order.where(state: @order_state)
    end

    def find_checkout_finished_orders
      Order.checkout_finished.order(created_at: :desc)
    end

    def valid_state?
      Order.states.except(:address, :delivery, :payment, :confirm).include?(@order_state)
    end
  end
end
