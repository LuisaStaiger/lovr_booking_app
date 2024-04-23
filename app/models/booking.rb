class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :love_pod
  belongs_to :festival
  validates :start_time, :duration, presence: true
end
