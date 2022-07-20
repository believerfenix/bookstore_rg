# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  helper_method :cart_items_count

  def cart_items_count
    Cart::CartItemsCountService.new(current_cart).call
  end

  def current_cart
    return Order.find(session[:cart_id]) if session[:cart_id]

    cart = Order.create
    session[:cart_id] = cart.id
    cart
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('authorization.not_authorized')
    redirect_to(root_path)
  end
end
