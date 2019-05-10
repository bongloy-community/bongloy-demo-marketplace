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
    redirect_to "#{Bongloy.connect_base}/oauth/authorize?client_id=#{Rails.application.credentials.client_id}&redirect_uri=#{new_dashboard_bongloy_connect_url}&response_type=code"
  end

  private

  def get_bongloy_user_data
    BongloyConnect.new(params[:code], new_dashboard_bongloy_connect_url).connect
  end
end
