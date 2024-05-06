class LovePod < ApplicationRecord
  has_many :available_slots, dependent: :destroy
  has_many :festival_love_pods, dependent: :destroy
  has_many :festivals, through: :festival_love_pods
  has_many :bookings, through: :available_slots

  validates :name, :description, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  # Method to check if the Love Pod is available for a given date, start time, end time
  def is_available_for?(date, start_time, end_time)
    bookings.none? do |booking|
      booking_date = booking.booking_date.to_date
      # Check if the booking overlaps in date and time
      booking_end_time = booking.start_time + booking.duration.minutes
      date == booking_date && (
        (start_time...end_time).overlaps?(booking.start_time...booking_end_time)
      )
    end
  end
end
