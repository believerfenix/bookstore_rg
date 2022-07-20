# frozen_string_literal: true

class OrderItemDecorator < Draper::Decorator
  delegate_all

  def subtotal
    book.price * quantity
  end
end
