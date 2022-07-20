# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :coupon, dependent: :destroy

  has_one :billing_address, -> { billing },
          inverse_of: :addressable, as: :addressable, class_name: 'Address', dependent: :destroy
  has_one :shipping_address, -> { shipping },
          inverse_of: :addressable, as: :addressable, class_name: 'Address', dependent: :destroy

  has_one :order_delivery_type, dependent: :destroy
  has_one :delivery_type, through: :order_delivery_type
  has_one :card, dependent: :destroy

  enum state: { address: 0, delivery: 1, payment: 2, confirm: 3, complete: 4 }

  aasm column: :state, enum: true do
    state :address, initial: true
    state :delivery, :payment, :confirm, :complete

    event(:delivery_step) { transitions from: :address, to: :delivery }
    event(:payment_step) { transitions from: :delivery, to: :payment }
    event(:confirm_step) { transitions from: :payment, to: :confirm }
    event(:complete_step) { transitions from: :confirm, to: :complete }
  end
end
