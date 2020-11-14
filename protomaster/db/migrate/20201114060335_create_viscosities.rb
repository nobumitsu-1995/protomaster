class CreateViscosities < ActiveRecord::Migration[6.0]
  def change
    create_table :viscosities do |t|
      t.string :formtype
      t.integer :proto_id
      t.string :number
      t.string :temp
      t.string :roter
      t.integer :speed1
      t.integer :speed2
      t.integer :vs1
      t.integer :vs2
      t.integer :user_id
      t.date :measureDate

      t.timestamps
    end
  end
end
