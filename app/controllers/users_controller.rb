class UsersController < ApplicationController
  def stripe_connect
    code = params[:code]

    response = HTTParty.post("https://connect.stripe.com/oauth/token",
                             query: {
                               client_secret: ENV.fetch("SECRET_KEY"),
                               code: code,
                               grant_type: "authorization_code"
                             })

    if response.key?("error")
      redirect_to users_show_url, notice: response["error_description"]
    else
      @user = User.find_by(id: current_user.id)
      @user.stripe_account_id = response["stripe_user_id"]
      @user.save
      "Successfully connected with Stripe!"
    end
  end

  def index
    stripe_connect if params[:code]
    @user = User.find(current_user.id).decorate
  end
end
