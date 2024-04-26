class RemoveTimeFrameFromBooking < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :time_frame, :datetime
  end
end
