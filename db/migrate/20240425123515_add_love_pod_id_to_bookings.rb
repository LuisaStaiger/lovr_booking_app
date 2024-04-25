class AddLovePodIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :love_pod_id, :integer
    add_index :bookings, :love_pod_id
  end
end
