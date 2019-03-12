class User < ApplicationRecord
  validates :shop_name, presence: true

  has_many :products
  has_many :orders

  validates :shop_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
