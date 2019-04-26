class Dashboard::BongloyConnectsController < Dashboard::BaseController
  def new
    result = get_stripe_user_data

    if result.key?("error")
      flash[:error] = result["error_description"]
    else
      current_user.authorize(result["stripe_user_id"])
      #flash[:success] = "Connected with stripe successfuly"
    end

    redirect_to dashboard_user_path(current_user.id)
  end

  def destroy
    Deauthorize.new(current_user).run
    redirect_to dashboard_user_path(current_user), notice: "User has been revoked"
  end

  private
  
  def get_stripe_user_data
    response = StripeConnect.new(params[:code]).connect
  end
end
