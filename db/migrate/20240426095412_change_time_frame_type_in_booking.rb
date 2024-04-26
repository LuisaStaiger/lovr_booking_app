class ChangeTimeFrameTypeInBooking < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :start_time, :datetime
    add_column :bookings, :start_time, :datetime
  end
end
