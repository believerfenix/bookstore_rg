# frozen_string_literal: true

module Cart
  class CartItemsCountService
    attr_reader :items_count

    def initialize(session)
      @session = session
    end

    def call
      current_cart ? current_cart.order_items.sum(&:quantity) : 0
    end

    private

    def current_cart
      Order.find_by(id: @session[:cart_id])
    end
  end
end
