class AvailableSlot < ActiveRecord::Base
  belongs_to :festival
  belongs_to :love_pod
  has_one :booking
  validates :date ,:time_frame, :start_time, :duration, presence: true
end
