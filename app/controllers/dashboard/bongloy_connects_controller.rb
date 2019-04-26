class Dashboard::BongloyConnectsController < ApplicationController
  # class Dashboard::BongloyConnectsController < Dashboard::BaseController
  before_action :authenticate_user!

  def index
    # move to create
    # introduce Workflow
    response = StripeConnect.new(params[:code]).connect

    if response.key?("error")
      flash[:error] = response["error_description"]
    else
      current_user.authorize(response["stripe_user_id"])
      flash[:success] =  "Connected with stripe successfuly"
    end

    redirect_to dashboard_user_path(current_user.id)
  end

  def destroy

    Deauthorize.new(current_user).run
    redirect_to dashboard_user_path(current_user), notice: "User has been revoked"
  end
end

