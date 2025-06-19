# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Post.destroy_all
User.destroy_all

# Create sample users
users = User.create!([
  {
    name: "Alice Wonder",
    email: "alice@example.com",
    password: "password123",
    password_confirmation: "password123"
  },
  {
    name: "Bob Secret",
    email: "bob@example.com",
    password: "password123",
    password_confirmation: "password123"
  },
  {
    name: "Charlie Mystery",
    email: "charlie@example.com",
    password: "password123",
    password_confirmation: "password123"
  }
])

# Create sample posts
posts = Post.create!([
  {
    title: "The Mystery of the Missing Coffee",
    body: "Someone keeps taking my coffee from the office fridge. I've marked it clearly with my name, but every morning it's gone. The investigation continues...",
    user: users[0]
  },
  {
    title: "My Secret Superpower",
    body: "I can predict exactly when the microwave will beep, even from another room. It's not that useful, but it's my hidden talent.",
    user: users[1]
  },
  {
    title: "Office Confession",
    body: "I'm the one who's been leaving positive sticky notes on everyone's computers. Seeing you all smile when you find them makes my day!",
    user: users[2]
  },
  {
    title: "Late Night Coding Sessions",
    body: "My most productive coding happens at 2 AM when the world is quiet and it's just me and my computer. There's something magical about debugging in the dark.",
    user: users[0]
  },
  {
    title: "The Elevator Ritual",
    body: "I always press the elevator button exactly three times. I know it doesn't make it come faster, but I can't help myself. It's become my superstition.",
    user: users[1]
  }
])

puts "Created #{User.count} users and #{Post.count} posts!"
