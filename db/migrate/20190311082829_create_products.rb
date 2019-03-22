class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :description, null: true
      t.integer :price, null: false
      t.timestamps
    end
  end
end
