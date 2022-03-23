# frozen_string_literal: true

class Address < ApplicationRecord
  has_many :user_addresses, dependent: :destroy
  has_many :users, through: :user_addresses

  enum kind: { billing: 0, shipping: 1 }
end
