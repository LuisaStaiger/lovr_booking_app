class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :love_pod

  validates :user_id, :love_pod_id, :start_time, :number_of_people, presence: true
  validates :number_of_people, numericality: { only_integer: true, greater_than: 0 }

  # Assuming you add a 'duration' integer field to explicitly store the booking length.
  validates :duration, inclusion: { in: [25, 55], message: "%{value} is not a valid duration" }, allow_nil: true

  validate :love_pod_capacity

  private

  def love_pod_capacity
    errors.add(:base, "LovePod cannot accommodate the number of people") if love_pod.capacity < number_of_people
  end
end


