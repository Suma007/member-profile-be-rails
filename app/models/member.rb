class Member < ApplicationRecord
  has_many :headings, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true

  def add_friend(friend)
    self.friends << friend unless self.friends.include?(friend)
  end
end
