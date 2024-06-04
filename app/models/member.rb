# frozen_string_literal: true

class Member < ApplicationRecord
  # associations
  has_many :headings, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_secure_password

  # validations
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true

  def add_friend(friend)
    if self == friend || friends.include?(friend)
      errors.add(:base, 'Friend is already added')
      false
    else
      friends << friend
      true
    end
  end
end
