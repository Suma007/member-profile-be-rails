require 'rails_helper'

RSpec.describe Heading, type: :model do
  it "is valid with valid attributes" do
    heading = FactoryBot.build(:heading)
    expect(heading).to be_valid
  end

  it "is not valid without a member" do
    heading = FactoryBot.build(:heading, member: nil)
    expect(heading).to_not be_valid
  end
end
