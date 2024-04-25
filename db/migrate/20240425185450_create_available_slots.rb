class CreateAvailableSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :available_slots do |t|
      t.datetime :date
      t.string :time_frame
      t.integer :duration
      t.references :festival, null: false, foreign_key: true

      t.timestamps
    end
  end
end
