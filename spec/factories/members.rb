FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    website_url { Faker::Internet.url }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
