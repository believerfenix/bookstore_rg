# frozen_string_literal: true

module Orders
  class SortOrdersService
    attr_reader :orders, :current_user

    ORDER_DEFAULT_FILTER = :checkout_complete

    def initialize(params)
      @order_state = params[:order_state]
      @current_user = params[:user]
    end

    def call
      @order_state ? find_orders : find_checkout_finished_orders
    end

    private

    def find_orders
      return unless valid_state?

      Order.where(state: @order_state, user_id: current_user.id)
    end

    def find_checkout_finished_orders
      Order.where(user_id: current_user.id).checkout_finished.order(created_at: :desc)
    end

    def valid_state?
      Order.states.except(:address, :delivery, :payment, :confirm).include?(@order_state)
    end
  end
end
