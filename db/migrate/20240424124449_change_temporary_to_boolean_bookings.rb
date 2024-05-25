class ChangeTemporaryToBooleanBookings < ActiveRecord::Migration[7.1]
  def up
    remove_column :bookings, :temporary, :boolean
  end

  def down
    add_column :bookings, :temporary, :boolean
  end
end
