class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :member_id, :friend_id, :created_at, :updated_at
  belongs_to :member
  belongs_to :friend, class_name: 'Member'
end
