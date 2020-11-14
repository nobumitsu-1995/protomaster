class Changecolumnname < ActiveRecord::Migration[6.0]
  def change
    rename_column :prototypes, :condition, :conditions
  end
end
