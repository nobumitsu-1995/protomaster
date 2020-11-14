class CreateVrvalues < ActiveRecord::Migration[6.0]
  def change
    create_table :vrvalues do |t|
      t.string :formtype
      t.integer :proto_id
      t.string :number
      t.string :compname
      t.float :comp
      t.float :color
      t.string :temp
      t.string :time
      t.float :brank
      t.float :test
      t.float :vr
      t.integer :user_id
      t.date :measureDate
      t.float :thickness
      t.integer :brank_expo
      t.integer :test_expo

      t.timestamps
    end
  end
end
