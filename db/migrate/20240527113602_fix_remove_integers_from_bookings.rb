class FixRemoveIntegersFromBookings < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:bookings, :festival_id)
      remove_column :bookings, :festival_id, :integer
    end
    if column_exists?(:bookings, :love_pod_id)
      remove_column :bookings, :love_pod_id, :integer
    end
  end
end
