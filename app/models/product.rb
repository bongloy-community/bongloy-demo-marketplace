class Product < ApplicationRecord
  self.table_name = "active_storage_attachments"
  belongs_to :user
  has_one_attached :cover_product
  validates :name, :price, presence: true
  validate :cover_product_presence

  delegate_missing_to :blob

  def cover_product_presence
    errors.add(:cover_product, "can't be blank") unless cover_product.attached?
  end
end
