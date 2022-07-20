# frozen_string_literal: true

class OrdersController < ApplicationController
  decorates_assigned :orders, :order

  def index
    @orders = Orders::SortOrdersService.new(order_state: params[:state], user: current_user).call
    authorize @order, policy_class: OrderPolicy
  end

  def show
    @order = Order.find_by(id: params[:id])
    authorize @order, policy_class: OrderPolicy
  end
end
