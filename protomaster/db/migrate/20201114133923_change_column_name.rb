class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :prototype, :condition, :conditions
  end
end
