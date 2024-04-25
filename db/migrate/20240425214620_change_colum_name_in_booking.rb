class ChangeColumNameInBooking < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :start_time, :datetime
    remove_column :bookings, :reservation_start, :datetime
    add_column :bookings, :time_frame, :datetime
  end
end
