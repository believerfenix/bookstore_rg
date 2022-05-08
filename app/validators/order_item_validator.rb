# frozen_string_literal: true

class OrderItemValidator < ActiveModel::Validator
  def validate(record)
    add_max_quantity_error(record) if record.quantity && record.book && record.quantity > record.book.quantity
  end

  private

  def add_max_quantity_error(record)
    record.errors.add(:quantity, I18n.t('cart.hight_quantity'))
  end
end
