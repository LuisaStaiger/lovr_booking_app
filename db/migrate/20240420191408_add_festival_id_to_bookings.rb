class AddFestivalIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :festival, null: true, foreign_key: true
  end
end

