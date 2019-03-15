class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_product

  validates :name, :price, presence: true
end
