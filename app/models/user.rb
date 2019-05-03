class User < ApplicationRecord
  has_many :products
  has_many :orders

  scope :buyable_product, -> { where(bongloy_account_id: "") }
  scope :latest_product, -> { buyable_product.last }


  validates :shop_name, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def authorize(bongloy_account_id)
    self.bongloy_account_id = bongloy_account_id
    self.products.each { |q| q.update_attribute(:status, true) }
    self.save!
  end

  def self.get_latest_product
    buyable_product.last
  end
end
