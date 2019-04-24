class Dashboard::BongloyConnectsController < ApplicationController
  before_action :authenticate_user!

  def index
    response = StripeConnect.new(params[:code]).connect

    if response.key?("error")
      redirect_to dashboard_user_path(current_user.id), notice: response["error_description"]
    else
      current_user.authorize(response["stripe_user_id"])
      redirect_to dashboard_user_path(current_user.id), notice: "Connected with stripe successfuly"
    end
  end

  def destroy
    acct = Stripe::Account.retrieve(current_user.stripe_account_id)
    acct.deauthorize(ENV.fetch("CLIENT_ID"))

    redirect_to dashboard_user_path(current_user), notice: "User has been revoked"
  end
end
