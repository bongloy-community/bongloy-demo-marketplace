class Deauthorize
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def run
    deauthorize_access
    @user.stripe_account_id = nil
    @user.save!
  end

  def deauthorize_access
    binding.pry
    acct = Stripe::Account.retrieve(@user.stripe_account_id)
    acct.deauthorize(ENV.fetch("CLIENT_ID"))
  end
end
