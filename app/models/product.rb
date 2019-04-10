class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_product
  validates :name, :price, presence: true
  validate :cover_product_presence

  scope :search, ->(name) { where('LOWER(name) LIKE ?', "%#{name.downcase}%") }

  def cover_product_presence
    errors.add(:cover_product, "can't be blank") unless cover_product.attached? 
  end

  def price_in_cents
    price * 100
  end
end
