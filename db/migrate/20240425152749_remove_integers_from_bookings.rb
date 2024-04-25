class RemoveIntegersFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :festival_id, :integer
    remove_column :bookings, :love_pod_id, :integer
  end
end
