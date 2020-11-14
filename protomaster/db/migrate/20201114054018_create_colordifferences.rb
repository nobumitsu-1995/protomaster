class CreateColordifferences < ActiveRecord::Migration[6.0]
  def change
    create_table :colordifferences do |t|
      t.string :formtype
      t.integer :proto_id
      t.string :number
      t.float :fullL
      t.float :fulla
      t.float :fullb
      t.float :tintL
      t.float :tinta
      t.float :tintb
      t.float :fulldL
      t.float :fullda
      t.float :fulldb
      t.float :fulldE
      t.float :tintdL
      t.float :tintda
      t.float :tintdb
      t.float :tintdE
      t.integer :user_id
      t.date :measureDate

      t.timestamps
    end
  end
end
