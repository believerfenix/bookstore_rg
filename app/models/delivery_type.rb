# frozen_string_literal: true

class DeliveryType < ApplicationRecord
  has_many :order_delivery_type, dependent: :destroy
  has_many :orders, through: :order_delivery_type
end
