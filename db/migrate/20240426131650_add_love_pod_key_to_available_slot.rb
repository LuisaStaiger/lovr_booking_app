class AddLovePodKeyToAvailableSlot < ActiveRecord::Migration[7.1]
  def change
    add_reference :available_slots, :love_pod, foreign_key: true
  end
end
