# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all if Rails.env.development?
Festival.destroy_all if Rails.env.development?
LovePod.destroy_all if Rails.env.development?

User.create!(email: "admin@mail.com", password: "123456", admin: true)
User.create!(email: "user@mail.com", password: "123456")

# Create Festivals
festival1 = Festival.create!(name: "Summer Music Fest", location: "Central Park", start_date: Date.new(2024, 6, 10), end_date: Date.new(2024, 6, 12))
festival2 = Festival.create!(name: "Winter Art Festival", location: "Downtown Gallery", start_date: Date.new(2024, 12, 5), end_date: Date.new(2024, 12, 8))

# Create Love Pods
love_pod1 = LovePod.create!(name: "Chill Zone", description: "A relaxing space for festival-goers to unwind.", capacity: 2)
love_pod2 = LovePod.create!(name: "Dance Sphere", description: "An energetic area for dancing and music.", capacity: 2)

# Link Festivals and Love Pods using FestivalLovePods
FestivalLovePod.create!(festival: festival1, love_pod: love_pod1)
FestivalLovePod.create!(festival: festival1, love_pod: love_pod2)
FestivalLovePod.create!(festival: festival2, love_pod: love_pod2)

# Create available slots
festivals = Festival.all
festivals.each do |festival|
  start_date = festival.start_date
  end_date = festival.end_date
  durations = [25, 55]

  durations.each do |duration|
    (start_date..end_date).each do |date|
      festival.love_pods.each do |pod|

        start_time = pod.availabilty_start_time
        end_time = pod.availabilty_end_time

        while start_time + duration.minutes <= end_time
          time_frame = "#{start_time.strftime('%H:%M')} - #{(start_time + duration.minutes).strftime('%H:%M')}"

          slot = AvailableSlot.new(date: date,
          time_frame: time_frame,
          start_time: start_time,
          duration: duration, festival: festival,
          love_pod: pod, price: 10)

          start_time += (duration + 5).minutes
          slot.save!
        end
      end
    end
  end
end


  # available_slots.each do |slot|
  #   date = slot[0].to_datetime
  #   time_frame = slot[1]
  #   start_time = slot[2]
  #   duration = slot[4]

  #   festival.love_pods.each do |pod|
  #     AvailableSlot.create!(date: date,
  #     time_frame: time_frame,
  #     start_time: start_time,
  #     duration: duration, festival: festival,
  #     love_pod: pod)
  #   end
  # end


# Output to confirm seeding
puts "Seeds created 🪴"
