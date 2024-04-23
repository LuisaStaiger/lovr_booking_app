class AddReservationDetailsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :reservation_start, :datetime
    add_column :bookings, :duration, :integer
    add_column :bookings, :temporary, :datetime
  end
end
