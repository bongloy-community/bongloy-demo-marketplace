class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items

  enum status: [:created, :succeeded]
 
  def create_line_item(item)
    line_items.create!(item)
  end
end
