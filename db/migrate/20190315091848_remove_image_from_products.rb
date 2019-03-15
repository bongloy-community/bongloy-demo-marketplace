class RemoveImageFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :image
  end
end
