class LovePod < ApplicationRecord
  has_many :festival_love_pods
  has_many :festivals, through: :festival_love_pods

  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  # Check if the LovePod is available for a booking at a given time with a certain number of people
  def is_available_for?(booking_date, start_time, duration, number_of_people)
    return false unless capacity >= number_of_people

    # Convert times to appropriate types if necessary
    booking_start = DateTime.parse("#{booking_date} #{start_time}")
    booking_end = booking_start + duration.minutes

    # Check for overlapping bookings
    bookings.none? do |existing_booking|
      existing_start = existing_booking.start_time
      existing_end = existing_start + existing_booking.duration.minutes
      (booking_start...booking_end).overlaps?(existing_start...existing_end)
    end
  end
end
