class Deauthorize
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def run
    deauthorize_access
    @user.update!(stripe_account_id: nil)
  end

  private

  def deauthorize_access
    acct = Stripe::Account.retrieve(@user.stripe_account_id)
    acct.deauthorize(ENV.fetch("CLIENT_ID"))
  end
end
