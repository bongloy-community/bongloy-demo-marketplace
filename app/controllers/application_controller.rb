class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :bongloy_account

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:shop_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:shop_name])
  end

  def bongloy_account
    if current_user.present? && current_user.bongloy_account_id.present?
      current_user.bongloy_account_id
    end
  end
end
