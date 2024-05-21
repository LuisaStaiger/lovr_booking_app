class ChangeMonetizeInBooking < ActiveRecord::Migration[7.1]
  def change
    remove_monetize :bookings, :price, currency: { present: false }
    add_monetize :bookings, :amount, currency: { present: false }
  end
end
