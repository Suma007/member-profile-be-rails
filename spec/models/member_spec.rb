require 'rails_helper'

RSpec.describe Member, type: :model do
  it "creates a member with valid attributes" do
    member = Member.new(name: "John Doe", website_url: "http://example.com", password: "password", password_confirmation: "password")
    expect(member).to be_valid
  end

  it "is invalid without a password" do
    member = Member.new(name: "John Doe", website_url: "http://example.com", password: nil)
    expect(member).to_not be_valid
  end

  it "is invalid with a short password" do
    member = Member.new(name: "John Doe", website_url: "http://example.com", password: "short", password_confirmation: "short")
    expect(member).to_not be_valid
  end
end
