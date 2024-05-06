class AddDurationColumnToLovePods < ActiveRecord::Migration[7.1]
  def change
    add_column :love_pods, :duration_25, :integer, default: 25
    add_column :love_pods, :duration_55, :integer, default: 55
  end
end
