class LovePod < ApplicationRecord
  belongs_to :festival
  has_many :bookings
end
