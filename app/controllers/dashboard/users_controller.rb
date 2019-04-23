class Dashboard::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id).decorate
    if params[:code]
      response = StripeConnect.new(params[:code]).connect

      if response.key?("error")
        redirect_to dashboard_users_path, notice: response["error_description"]
      else
        @user.stripe_account_id = response["stripe_user_id"]
        @user.save
      end
    end
  end
end
