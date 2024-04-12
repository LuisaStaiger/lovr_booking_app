class AddDescriptionToLovePods < ActiveRecord::Migration[7.1]
  def change
    add_column :love_pods, :description, :text
  end
end
