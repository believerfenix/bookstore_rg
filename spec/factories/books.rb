# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    price { Faker::Number.decimal(l_digits: 2) }
    quantity { Faker::Number.between(from: 1, to: 100) }
    description { Faker::Lorem.paragraph_by_chars }
    publication_year { Faker::Number.between(from: 1, to: 100) }
    height { Faker::Number.decimal(l_digits: 2) }
    width { Faker::Number.decimal(l_digits: 2) }
    depth { Faker::Number.decimal(l_digits: 2) }
    materials { Faker::Science.element }
    authors { create_list(:author, 2) }
    category
  end
end
