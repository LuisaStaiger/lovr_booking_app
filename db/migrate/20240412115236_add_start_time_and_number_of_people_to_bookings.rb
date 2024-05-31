class AddStartTimeAndNumberOfPeopleToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :start_time, :datetime
  end
end
