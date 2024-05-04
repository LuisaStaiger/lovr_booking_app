class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :available_slot
  validates :booking_date, :start_time, :duration, presence: true

  # validates :available_slot_id, uniqueness: { scope: [:booking_date, :love_pod_id] }

  enum status: {
    pending: 0,
    confirmed: 1,
    declined: 2
  }
end
