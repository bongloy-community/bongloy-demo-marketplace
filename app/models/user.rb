class User < ApplicationRecord
  has_many :products
  has_many :orders

  validates :shop_name, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def authorize(stripe_user_id)
    self.stripe_account_id = stripe_user_id
    self.save!
  end

  def deauthorize
    acct = Stripe::Account.retrieve(self.stripe_account_id)
    acct.deauthorize(ENV.fetch("CLIENT_ID"))
    self.stripe_account_id = nil
    self.save!
  end
end
