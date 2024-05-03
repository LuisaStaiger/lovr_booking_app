class RemoveKeysFromBooking < ActiveRecord::Migration[7.1]
  def change
    remove_reference :bookings, :love_pod, foreign_key: true
    remove_reference :bookings, :festival, foreign_key: true
  end
end
