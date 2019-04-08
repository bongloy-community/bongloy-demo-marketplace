class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    stripe_connect if params[:code]
    @user = User.find(current_user.id).decorate
  end

  private

  def stripe_connect
    parameters = {
      client_secret: ENV.fetch("SECRET_KEY"),
      code: params[:code],
      grant_type: "authorization_code"
    }

    response = HTTParty.post("https://connect.stripe.com/oauth/token", query: parameters)

    if response.key?("error")
      redirect_to dashboard_users_path, notice: response["error_description"]
    else
      @user = User.find_by(id: current_user.id)
      @user.stripe_account_id = response["stripe_user_id"]
      @user.save
    end
  end
end
