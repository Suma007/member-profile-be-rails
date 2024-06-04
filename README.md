# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version ruby-3.3.1

* System dependencies
sidekiq

* Configuration

* Database creation
rails db:create

* Database initialization
rails db:migrate

* How to run the test suite
bundle exec rspec

* Services (job queues, cache servers, search engines, etc.)
bundle exec sidekiq - run the sidekiq
wsl sudo service redis-server status

* Deployment instructions

* 
I can create a "Member" by entering a name and their website address/URL.
When a member is added, all the headings (h1-h3) on their website should be retrieved and stored.
Members can be friends with other members. Friendships are bi-directional (i.e. if A is friends with B, then B is friends with A).
Add a search function to the homepage. The search input should match headings collected from member websites, and it should return a list of members and the relevant matched heading.
Add a similar search function to a member's profile page to help members figure out how to be introduced to other members. Perform this search in the context of the member (i.e. avoid returning the same member in results) and enhance the search results here to output the shortest path from the member to the search result members (e.g. if C is a result when searching from member A’s profile page, then A -> B -> C might be the shortest path).





