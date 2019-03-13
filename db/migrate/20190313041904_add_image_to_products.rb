class AddImageToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :image, :string, null: true
  end
end
