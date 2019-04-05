class User < ApplicationRecord
  has_many :products
  has_many :orders

  validates :shop_name, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
