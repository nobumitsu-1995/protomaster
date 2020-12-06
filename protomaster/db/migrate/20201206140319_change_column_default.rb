class ChangeColumnDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :admin_user, :boolean, default: false
  end
end
