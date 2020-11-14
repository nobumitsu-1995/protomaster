class CreatePigments < ActiveRecord::Migration[6.0]
  def change
    create_table :pigments do |t|
      t.integer :code
      t.string :name
      t.string :maker
      t.string :pig_no
      t.string :structure

      t.timestamps
    end
  end
end
