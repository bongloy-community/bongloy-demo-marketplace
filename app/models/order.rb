class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items
  has_many :product, through: :line_items

  enum status: [:created, :succeeded]

  def create_line_item(item)
    line_items.create!(item)
  end

  def amount
    self.total / 100
  end

  def payment
    JSON.parse(payment_details, object_class: OpenStruct)
  end
end
