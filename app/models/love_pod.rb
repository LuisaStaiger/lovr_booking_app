class LovePod < ApplicationRecord
  has_many :available_slots, dependent: :destroy
  has_many :festival_love_pods, dependent: :destroy
  has_many :festivals, through: :festival_love_pods
  has_many :bookings, through: :available_slots
  has_one_attached :photo

  validates :name, :description, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
end
