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

  enum state: { address: 0, delivery: 1, payment: 2, confirm: 3, checkout_complete: 4,
                in_delivery: 5, delivered: 6, canceled: 7 }

  scope :in_progress, -> { where(state: %i[address delivery payment confirm checkout_complete in_delivery]) }
  scope :in_queue, -> { where(state: :checkout_complete) }
  scope :in_delivery, -> { where(state: :in_delivery) }
  scope :delivered, -> { where(state: :delivered) }
  scope :canceled, -> { where(state: :canceled) }
  scope :checkout_finished, -> { where(state: %i[checkout_complete in_delivery delivered canceled]) }

  aasm column: :state, enum: true do
    state :address, initial: true
    state :delivery, :payment, :confirm, :checkout_complete,
          :in_delivery, :delivered, :canceled

    event(:delivery_step) { transitions from: :address, to: :delivery }
    event(:payment_step) { transitions from: :delivery, to: :payment }
    event(:confirm_step) { transitions from: :payment, to: :confirm }
    event(:complete_step) { transitions from: :confirm, to: :checkout_complete }
    event(:in_delivery_step) { transitions from: :checkout_complete, to: :in_delivery }
    event(:delivered_step) { transitions from: :in_delivery, to: :delivered }
    event(:canceled_step) { transitions from: %i[checkout_complete in_delivery delivered], to: :canceled }
  end
end
