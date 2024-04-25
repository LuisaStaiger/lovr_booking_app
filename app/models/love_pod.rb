class LovePod < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :festival_love_pods
  has_many :festivals, through: :festival_love_pods

  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  # Method to check if the Love Pod is available for a given date, start time, end time
  def is_available_for?(date, start_time, end_time)
    bookings.none? do |booking|
      booking_date = booking.time_frame.to_date
      # Check if the booking overlaps in date and time
      booking_end_time = booking.time_frame + booking.duration.minutes
      date == booking_date && (
        (time_frame...end_time).overlaps?(booking.time_frame...booking_end_time)
      )
    end
  end
end
