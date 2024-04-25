class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :love_pod
  validates :date, :start_time, :duration, presence: true

  enum status: {
    pending: 0,
    confirmed: 1,
    declined: 2
  }
end
