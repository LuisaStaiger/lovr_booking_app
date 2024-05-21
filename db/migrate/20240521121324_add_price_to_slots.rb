class AddPriceToSlots < ActiveRecord::Migration[7.1]
  def change
    add_monetize :available_slots, :price, currency: { present: false }
  end
end
