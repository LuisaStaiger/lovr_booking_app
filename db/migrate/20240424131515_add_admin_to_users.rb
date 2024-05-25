class AddAdminToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists? :users, :admin
      add_column :users, :admin, :boolean, default: false
    end
  end
end
