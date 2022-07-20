# frozen_string_literal: true

module Cart
  class CartItemsCountService
    attr_reader :items_count

    def initialize(current_cart)
      @current_cart = current_cart
    end

    def call
      @current_cart.order_items.sum(&:quantity)
    end
  end
end
