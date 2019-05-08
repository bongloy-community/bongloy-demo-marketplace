class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.jsonb :payment_details, default: {}, null: true
      t.string :charge_id, null: true
      t.integer :total, null: true
      t.integer :status, null: false
      t.timestamps
    end
  end
end
