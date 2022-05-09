# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    order_items { [] }
  end

  trait :with_coupon do
    coupon
  end
end
