class Changecolumnname < ActiveRecord::Migration[6.0]
  def change
    rename_column :, :condition, :conditions
  end
end
