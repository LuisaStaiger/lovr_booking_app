class AddImageUrlToFestival < ActiveRecord::Migration[7.1]
  def change
    add_column :festivals, :image_url, :string
  end
end
