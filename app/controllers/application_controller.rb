# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  helper_method :cart_items_count

  def cart_items_count
    Cart::CartItemsCountService.new(session).call
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('authorization.not_authorized')
    redirect_to(root_path)
  end
end
