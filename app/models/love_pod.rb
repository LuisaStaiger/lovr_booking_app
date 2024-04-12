class LovePod < ApplicationRecord
  belongs_to :festival
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  # Add more validations as needed, e.g., ensuring capacity is a number greater than zero.
end
