class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_product
  validates :name, :price, presence: true

  validate :cover_product_presence

  def cover_product_presence
    errors.add(:cover_product, "can't be blank") unless cover_product.attached?
  end

  def price_in_cents
    self.price * 100
  end
end
