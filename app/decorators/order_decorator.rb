# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_associations :order_items, :addresses, :card

  def order_items_subtotal
    order_items.sum(&:subtotal)
  end

  def discount
    coupon&.sale || 0.0
  end

  def delivery_price
    delivery_type&.price || 0.0
  end

  def order_discount
    - order_items_subtotal * discount
  end

  def order_total
    order_items_subtotal + delivery_price + order_discount
  end

  def address_credentials_full_name(kind)
    order_address(kind).decorate.full_name
  end

  def order_address_address(kind)
    order_address(kind).address
  end

  def order_address_country(kind)
    ISO3166::Country.find_country_by_alpha2(order_address(kind).country)
  end

  def address_city_with_zip(kind)
    "#{order_address(kind).city} #{order_address(kind).zip}"
  end

  def address_phone(kind)
    order_address(kind).phone
  end

  def order_address(kind)
    kind == 'billing' ? billing_address : shipping_address
  end

  def state_done?(state)
    state_before_type_cast > Order.states[state]
  end

  def last_state?(index)
    Order.states.count - 1 == index
  end

  def passed_state?(state)
    state_done?(state) || self.state == state
  end
end
