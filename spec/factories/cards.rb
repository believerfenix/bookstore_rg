# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    number { Faker::Finance.credit_card.delete('-') }
    name { Faker::Name.first_name }
    expiry_date { '12/34' }
    cvv { rand(100..999) }
  end
end
