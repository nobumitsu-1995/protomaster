class CreatePrototypes < ActiveRecord::Migration[6.0]
  def change
    create_table :prototypes do |t|
      t.integer :user_id
      t.string :formtype
      t.integer :name
      t.string :number
      t.text :condition
      t.string :particle
      t.text :memo
      t.integer :client
      t.date :measureDate

      t.timestamps
    end
  end
end
