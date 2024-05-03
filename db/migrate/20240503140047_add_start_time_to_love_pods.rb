class AddStartTimeToLovePods < ActiveRecord::Migration[7.1]
  def change
    add_column :available_slots, :start_time, :datetime
  end
end
