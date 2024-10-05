# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
  end
end
