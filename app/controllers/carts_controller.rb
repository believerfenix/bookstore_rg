# frozen_string_literal: true

class CartsController < ApplicationController
  decorates_assigned :cart

  def show
    @cart = current_cart.decorate
  end

  def update
    service = Cart::UpdateCartService.call(order: current_cart, order_params: cart_params)
    if service.success?
      flash[:success] = service.success_message
    else
      flash[:danger] = service.errors_message
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_params
    params.require(:order).permit(coupon: :code, order_item: %i[quantity book_id destroy_id])
  end
end
