class ChangeColumnAdminUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :admin_user
    add_column :users, :admin_user, :integer, default: 0
  end
end
