# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all

User.create!(email: "admin@mail.com", password: "123456", admin: true)
User.create!(email: "user@mail.com", password: "123456")

# Create Festivals
festival1 = Festival.create!(name: "Summer Music Fest", location: "Central Park", start_date: Date.new(2024, 6, 10), end_date: Date.new(2024, 6, 12))
festival2 = Festival.create!(name: "Winter Art Festival", location: "Downtown Gallery", start_date: Date.new(2024, 12, 5), end_date: Date.new(2024, 12, 8))

# Create Love Pods
love_pod1 = LovePod.create!(name: "Chill Zone", description: "A relaxing space for festival-goers to unwind.", capacity: 10)
love_pod2 = LovePod.create!(name: "Dance Sphere", description: "An energetic area for dancing and music.", capacity: 5)

# Link Festivals and Love Pods using FestivalLovePods
FestivalLovePod.create!(festival: festival1, love_pod: love_pod1)
FestivalLovePod.create!(festival: festival1, love_pod: love_pod2)
FestivalLovePod.create!(festival: festival2, love_pod: love_pod2)

# Output to confirm seeding
puts "Seed created"
