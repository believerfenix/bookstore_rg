# frozen_string_literal: true

class Coupon < ApplicationRecord
  SALE_RANGE = { min: 0.0, max: 1.0 }.freeze

  belongs_to :order, optional: true

  validates :sale, :code, presence: true
  validates :sale, numericality: { greater_than_or_equal_to: SALE_RANGE[:min] }
  validates :sale, numericality: { less_than_or_equal_to: SALE_RANGE[:max] }
end
