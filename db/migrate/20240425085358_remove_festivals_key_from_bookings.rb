class RemoveFestivalsKeyFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :festivals, foreign_key: true
  end
end
