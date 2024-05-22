class Festival < ApplicationRecord
  has_many :festival_love_pods, dependent: :destroy
  has_many :love_pods, through: :festival_love_pods
  has_many :available_slots, dependent: :destroy
  has_many :bookings, through: :available_slots, dependent: :destroy
  has_one_attached :photo

  validates :name ,:location, :start_date, :end_date, presence: true
end
