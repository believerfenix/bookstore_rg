# frozen_string_literal: true

class OrdersController < ApplicationController
  decorates_assigned :orders, :order

  def index
    @orders = Orders::SortOrdersService.new(order_state: params[:state]).call
  end

  def show
    @order = Order.find_by(id: params[:id])
  end
end
