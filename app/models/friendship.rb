class Friendship < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  validates :member_id, uniqueness: { scope: :friend_id }
end
