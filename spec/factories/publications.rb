# frozen_string_literal: true

FactoryBot.define do
  factory :publication do
    title { Faker::Book.title[0..39] }
    body { Faker::Lorem.paragraphs(number: 3).join("\n") }
    status { Publication.statuses.keys.sample }
    author

    trait :draft do
      status { Publication.statuses['draft'] }
      published_at { DateTime.now }
    end

    trait :published do
      status { Publication.statuses['published'] }
      published_at { Faker::Date.between(from: DateTime.now, to: 1.week.after) }
    end

    trait :deleted do
      status { Publication.statuses['deleted'] }
      deleted_at { DateTime.now }
    end
  end
end
