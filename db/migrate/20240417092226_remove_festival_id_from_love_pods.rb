class RemoveFestivalIdFromLovePods < ActiveRecord::Migration[7.1]
  def change
    remove_column :love_pods, :festival_id, :bigint
  end
end
