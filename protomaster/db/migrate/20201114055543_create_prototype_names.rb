class CreatePrototypeNames < ActiveRecord::Migration[6.0]
  def change
    create_table :prototype_names do |t|
      t.string :name
      t.string :formtype
      t.integer :user_id
      t.integer :client

      t.timestamps
    end
  end
end
