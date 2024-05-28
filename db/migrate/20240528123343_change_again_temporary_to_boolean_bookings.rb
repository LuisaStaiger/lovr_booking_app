class ChangeAgainTemporaryToBooleanBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :temporary
    add_column :bookings, :status, :integer, default: 0
  end
end
