class MemberSerializer < ActiveModel::Serializer
  attributes :id, :name, :website_url, :created_at, :updated_at
  has_many :headings
  has_many :friends

  def friends
    object.friends.map do |friend|
      FriendSerializer.new(friend)
    end
  end

end


class FriendSerializer < ActiveModel::Serializer
  attributes :id, :name, :website_url
end