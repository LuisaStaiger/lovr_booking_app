class LovePod < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  # Method to check if the Love Pod is available for a given date, start time, end time, and number of people
  def is_available_for?(date, start_time, end_time, number_of_people)
    return false if self.capacity < number_of_people  # Check capacity first

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
