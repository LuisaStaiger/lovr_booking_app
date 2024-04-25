class RemoveFestivalIdFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_reference :bookings, :festival, foreign_key: true
  end
end
