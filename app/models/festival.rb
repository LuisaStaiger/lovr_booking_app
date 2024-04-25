class Festival < ApplicationRecord
  has_many :festival_love_pods
  has_many :love_pods, through: :festival_love_pods
  has_many :bookings, dependent: :destroy
  has_many :available_slot, dependent: :destroy
end
