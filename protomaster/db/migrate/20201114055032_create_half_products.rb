class CreateHalfProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :half_products do |t|
      t.integer :code
      t.string :name
      t.string :pigment
      t.float :pigment_per
      t.string :dispersant
      t.float :dispersant_per
      t.string :pigment2
      t.float :pigment2_per
      t.string :dispersant2
      t.float :dispersant2_per
      t.string :plasticizer

      t.timestamps
    end
  end
end
