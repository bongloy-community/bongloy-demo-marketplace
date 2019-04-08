class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_product
  validates :name, :price, presence: true

  def price_in_cents
    price * 100
  end
end
