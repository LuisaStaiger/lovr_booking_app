class AddCapacityToLovePods < ActiveRecord::Migration[7.1]
  def change
    add_column :love_pods, :capacity, :integer
  end
end
