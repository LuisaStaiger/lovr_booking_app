class AddStartEndTimeToLovePods < ActiveRecord::Migration[7.1]
  def change
    add_column :love_pods, :availabilty_start_time, :time, default: '09:00:00'
    add_column :love_pods, :availabilty_end_time, :time, default: '23:00:00'
  end
end
