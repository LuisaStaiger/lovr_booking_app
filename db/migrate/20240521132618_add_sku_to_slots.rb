class AddSkuToSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :available_slots, :sku, :string
  end
end
