FactoryBot.define do
  factory :heading do
    level { rand(1..3) }
    content_value { Faker::Lorem.sentence }
    association :member
  end
end
