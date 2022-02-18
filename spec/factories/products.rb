# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    description { Faker::Food.description }
    price { Faker::Commerce.price(range: 100.0..400.0) }
    avaiable { true }
    category
  end
end
