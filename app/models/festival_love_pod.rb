class FestivalLovePod < ApplicationRecord
  belongs_to :festival
  belongs_to :love_pod
  has_many :bookings
end
