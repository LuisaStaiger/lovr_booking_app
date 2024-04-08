class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :love_pod, null: false, foreign_key: true
      t.date :booking_date
      t.string :time_slot

      t.timestamps
    end
  end
end
