class AddFestivalIdFromBookings < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :festival, foreign_key: true
    remove_reference :bookings, :love_pod, foreign_key: true
  end
end
