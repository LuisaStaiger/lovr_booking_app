class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :available_slot
  validates :booking_date, :start_time, :duration, presence: true

  enum status: {
    pending: 0,
    confirmed: 1,
    declined: 2
  }
end
