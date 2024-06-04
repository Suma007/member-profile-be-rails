# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member do
  it 'creates a member with valid attributes' do
    member = described_class.new(name: 'John Doe', website_url: 'http://example.com', password: 'password',
                                 password_confirmation: 'password')
    expect(member).to be_valid
  end

  it 'is invalid without a password' do
    member = described_class.new(name: 'John Doe', website_url: 'http://example.com', password: nil)
    expect(member).not_to be_valid
  end

  it 'is invalid with a short password' do
    member = described_class.new(name: 'John Doe', website_url: 'http://example.com', password: 'short',
                                 password_confirmation: 'short')
    expect(member).not_to be_valid
  end
end
