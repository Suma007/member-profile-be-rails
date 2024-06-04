# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship do
  it 'is valid with valid attributes' do
    friendship = build(:friendship)
    expect(friendship).to be_valid
  end

  it 'is not valid without a member' do
    friendship = build(:friendship, member: nil)
    expect(friendship).not_to be_valid
  end

  it 'is not valid without a friend' do
    friendship = build(:friendship, friend: nil)
    expect(friendship).not_to be_valid
  end

  it 'is not valid with duplicate friendship' do
    member = create(:member)
    friend = create(:member)
    create(:friendship, member:, friend:)
    duplicate_friendship = build(:friendship, member:, friend:)
    expect(duplicate_friendship).not_to be_valid
  end
end
