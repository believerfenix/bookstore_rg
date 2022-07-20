# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :current_cart
  decorates_assigned :cart

  def update
    service = Cart::UpdateCartService.call(order: @cart, order_params: cart_params)
    if service.success?
      flash[:success] = service.success_message
    else
      flash[:danger] = service.errors_message
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def current_cart
    session[:cart_id] ? find_cart : set_cart
  end

  def set_cart
    @cart = Order.create
    session[:cart_id] = @cart.id
  end

  def find_cart
    @cart = Order.find(session[:cart_id])
  end

  def cart_params
    params.require(:order).permit(coupon: :code, order_item: %i[quantity book_id destroy_id])
  end
end
