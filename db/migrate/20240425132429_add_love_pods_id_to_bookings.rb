class AddLovePodsIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :love_pod, foreign_key: true
  end
end
