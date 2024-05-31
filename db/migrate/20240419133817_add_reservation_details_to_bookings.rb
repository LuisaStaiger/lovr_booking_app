class AddReservationDetailsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :duration, :integer
  end
end
