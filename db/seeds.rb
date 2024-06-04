# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Seed members
john_doe = Member.create(name: 'John Doe', website_url: 'https://example.com', password: 'password')
jane_smith = Member.create(name: 'Jane Smith', website_url: 'https://example.org', password: 'password')

# Seed friendships
Friendship.create(member_id: john_doe.id, friend_id: jane_smith.id)
Friendship.create(member_id: jane_smith.id, friend_id: john_doe.id)

# Seed headings
headings_data = [
  # Headings for John Doe
  { member_id: john_doe.id, level: 1, content_value: 'Introduction' },
  { member_id: john_doe.id, level: 2, content_value: 'Overview of the topic' },
  { member_id: john_doe.id, level: 3, content_value: 'Background information' },
  { member_id: john_doe.id, level: 3, content_value: 'Key concepts' },
  { member_id: john_doe.id, level: 2, content_value: 'Implementation' },
  { member_id: john_doe.id, level: 3, content_value: 'Setup instructions' },

  
  # Headings for Jane Smith
  { member_id: jane_smith.id, level: 1, content_value: 'Introduction' },
  { member_id: jane_smith.id, level: 2, content_value: 'Overview of the subject' },
  { member_id: jane_smith.id, level: 3, content_value: 'Historical background' },
  { member_id: jane_smith.id, level: 3, content_value: 'Current trends' },
  { member_id: jane_smith.id, level: 2, content_value: 'Case studies' },
  { member_id: jane_smith.id, level: 3, content_value: 'Case study 1: Example A' },
  { member_id: jane_smith.id, level: 3, content_value: 'Case study 2: Example B' }

]

headings_data.each do |heading_params|
  Heading.create(heading_params)
end
