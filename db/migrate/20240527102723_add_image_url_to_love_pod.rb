class AddImageUrlToLovePod < ActiveRecord::Migration[7.1]
  def change
    add_column :love_pods, :image_url, :string
  end
end
