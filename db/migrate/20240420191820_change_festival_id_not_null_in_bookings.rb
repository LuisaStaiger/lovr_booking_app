class ChangeFestivalIdNotNullInBookings < ActiveRecord::Migration[7.1]
  def change
    change_column_null :bookings, :festival_id, false
  end
end
