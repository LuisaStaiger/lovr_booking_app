class UpdateBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :slots_sku, :string
    add_monetize :bookings, :price, currency: { present: false }
    add_column :bookings, :checkout_session_id, :string
  end
end
