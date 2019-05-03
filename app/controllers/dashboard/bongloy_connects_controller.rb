class Dashboard::BongloyConnectsController < Dashboard::BaseController
  def new
    result = get_bongloy_user_data

    if result.key?("error")
      flash[:error] = result["error_description"]
    else
      current_user.authorize(result["bongloy_account_id"])
      flash[:success] = "Connected with bongloy successfuly"
    end

    redirect_to dashboard_user_path(current_user.id)
  end

  def authorize
    redirect_to "https://staging-sandbox.bongloy.com/oauth/authorize?client_id=#{ENV['CLIENT_ID']}&redirect_uri=https://4f5d3892.ngrok.io/dashboard%2Fbongloy_connects%2Fnew&response_type=code"
  end

  private

  def get_bongloy_user_data
    BongloyConnect.new(params[:code]).connect
  end
end
