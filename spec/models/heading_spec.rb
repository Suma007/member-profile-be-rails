# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heading do
  it 'is valid with valid attributes' do
    heading = build(:heading)
    expect(heading).to be_valid
  end

  it 'is not valid without a member' do
    heading = build(:heading, member: nil)
    expect(heading).not_to be_valid
  end
end
