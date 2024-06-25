class AvailableSlot < ActiveRecord::Base
  belongs_to :festival
  belongs_to :love_pod
  has_one :booking, dependent: :destroy

  validates :date ,:time_frame, :start_time, :duration, :price, presence: true
  
  monetize :price_cents
end
