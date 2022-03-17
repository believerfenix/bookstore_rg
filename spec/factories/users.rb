# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "#{Faker::Internet.password(min_length: 8, max_length: 15, mix_case: true)}1" }
    confirmed_at { Time.zone.now }
  end
end
