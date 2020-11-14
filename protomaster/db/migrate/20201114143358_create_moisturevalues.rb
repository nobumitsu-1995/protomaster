class CreateMoisturevalues < ActiveRecord::Migration[6.0]
  def change
    create_table :moisturevalues do |t|
      t.string :formtype
      t.integer :proto_id
      t.string :number
      t.date :measureDate
      t.string :temp
      t.string :time
      t.float :endpoint
      t.float :MV
      t.integer :user_id

      t.timestamps
    end
  end
end
