require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it "is valid with valid attributes" do
    friendship = FactoryBot.build(:friendship)
    expect(friendship).to be_valid
  end

  it "is not valid without a member" do
    friendship = FactoryBot.build(:friendship, member: nil)
    expect(friendship).to_not be_valid
  end

  it "is not valid without a friend" do
    friendship = FactoryBot.build(:friendship, friend: nil)
    expect(friendship).to_not be_valid
  end

  it "is not valid with duplicate friendship" do
    member = FactoryBot.create(:member)
    friend = FactoryBot.create(:member)
    FactoryBot.create(:friendship, member: member, friend: friend)
    duplicate_friendship = FactoryBot.build(:friendship, member: member, friend: friend)
    expect(duplicate_friendship).to_not be_valid
  end
end
