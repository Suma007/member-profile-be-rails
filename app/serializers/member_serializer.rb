# frozen_string_literal: true

class MemberSerializer < ActiveModel::Serializer
  attributes :id, :name, :website_url, :created_at, :updated_at
  has_many :headings
  has_many :friends, through: :friendships
end
