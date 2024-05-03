class Festival < ApplicationRecord
  has_many :festival_love_pods
  has_many :love_pods, through: :festival_love_pods
  has_many :available_slots
  has_many :bookings, through: :available_slots

  validates :name ,:location, :start_date, :end_date, presence: true
end
