# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_associations :order_items

  def order_items_subtotal
    order_items.sum(&:subtotal)
  end

  def discount
    coupon&.sale || 0.0
  end

  def order_discount
    order_items_subtotal * discount
  end

  def order_total
    order_items_subtotal - order_discount
  end
end
