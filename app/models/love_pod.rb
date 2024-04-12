class LovePod < ApplicationRecord
  belongs_to :festival
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
end
