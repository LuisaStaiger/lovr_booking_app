class LovePod < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :festival_love_pods
  has_many :festivals, through: :festival_love_pods

  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  # Method to check if the Love Pod is available for a given date, start time, end time, and number of people
  def is_available_for?(date, start_time, end_time)

    bookings.none? do |booking|
      booking_date = booking.start_time.to_date
      # Check if the booking overlaps in date and time
      booking_end_time = booking.start_time + booking.duration.minutes
      date == booking_date && (
        (start_time...end_time).overlaps?(booking.start_time...booking_end_time)
      )
    end
  end
end
