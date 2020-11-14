class CreateColorviewings < ActiveRecord::Migration[6.0]
  def change
    create_table :colorviewings do |t|
      t.string :formtype
      t.integer :proto_id
      t.string :number
      t.string :comp
      t.float :fullcomp
      t.float :fullcolor
      t.float :tintcomp
      t.float :tintcolor
      t.float :tc_value
      t.string :tc
      t.integer :user_id
      t.date :measureDate
      t.string :thickness
      t.string :temp
      t.string :time
      t.string :testShape

      t.timestamps
    end
  end
end
