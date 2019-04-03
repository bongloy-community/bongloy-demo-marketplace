class ChangeStatusTypeInOrder < ActiveRecord::Migration[5.2]
  def self.up
    change_column :orders, :status, 'integer USING CAST(status AS integer)'
  end
  
  def self.down
    change_column :orders, :status, :string
  end
end
