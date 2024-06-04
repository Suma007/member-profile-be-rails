# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    member
    friend factory: %i[member]
  end
end
