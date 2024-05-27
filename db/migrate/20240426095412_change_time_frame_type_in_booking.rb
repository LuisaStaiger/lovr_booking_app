class ChangeTimeFrameTypeInBooking < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:bookings, :start_time)
      remove_column :bookings, :start_time, :datetime
    end
  end
end
