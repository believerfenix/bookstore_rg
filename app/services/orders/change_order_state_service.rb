# frozen_string_literal: true

module Orders
  class ChangeOrderStateService < BaseService
    attr_reader :completed_order

    def initialize(params)
      super
      @state = params[:state]
      @order = params[:order]
      @user = params[:user]
    end

    def call
      return unless valid_state?

      @order.update(state: @state)

      complete_order if @state == Order.states.key(4)
    end

    private

    def complete_order
      OrderMailer.order_completed(@order, @user).deliver

      @user.orders << @order
      @completed_order = @order
    end

    def valid_state?
      Order.states.except(:delivered, :canceled, :in_delivery).include?(@state)
    end
  end
end
