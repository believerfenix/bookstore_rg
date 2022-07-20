# frozen_string_literal: true

class OrderItem < ApplicationRecord
  validates_with OrderItemValidator

  MIN_QUANTITY = 1

  belongs_to :book
  belongs_to :order

  validates :book, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: MIN_QUANTITY, message: I18n.t('cart.low_quantity') }
end
