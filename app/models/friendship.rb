# frozen_string_literal: true

class Friendship < ApplicationRecord
  # associations
  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  # validations
  validates :member_id, uniqueness: { scope: :friend_id }
end
