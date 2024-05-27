class RemoveAdminFromUsers < ActiveRecord::Migration[7.1]
  def change
    if ActiveRecord::Base.connection.column_exists?(:users, :admin)
      remove_column :users, :admin, :boolean
    end
  end
end
