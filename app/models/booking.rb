class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :love_pod
  belongs_to :festival
  validates :booking_date, :time_frame, :duration, presence: true

  enum status: {
    pending: 0,
    confirmed: 1,
    declined: 2
  }
end
