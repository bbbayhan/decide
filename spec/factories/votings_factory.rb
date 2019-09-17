# frozen_string_literal: true

FactoryBot.define do
  factory :voting do
    sequence(:title) { |n| "Title of voting #{n}" }
    sequence(:description) { |n| "Description of voting #{n}" }
    status { :draft }

    trait(:invalid) { title { nil } }
  end
end
