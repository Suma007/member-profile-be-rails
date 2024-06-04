# frozen_string_literal: true

FactoryBot.define do
  factory :heading do
    level { rand(1..3) }
    content_value { Faker::Lorem.sentence }
    member
  end
end
