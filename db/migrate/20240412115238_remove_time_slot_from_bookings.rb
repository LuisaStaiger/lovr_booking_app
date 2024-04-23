class RemoveTimeSlotFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :time_slot, :string
  end
end
