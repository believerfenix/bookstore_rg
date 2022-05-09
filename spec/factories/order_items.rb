# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    book
    order
    quantity { Faker::Number.between(from: 2, to: 10) }
  end
end
