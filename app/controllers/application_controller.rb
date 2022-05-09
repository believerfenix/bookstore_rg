# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :cart_items_count

  def cart_items_count
    Cart::CartItemsCountService.new(session).call
  end
end
