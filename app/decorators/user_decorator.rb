class UserDecorator < ApplicationDecorator
  include Rails.application.routes.url_helpers
  delegate_all

  def bongloy_connect_account
    if object.bongloy_account_id.nil? || object.bongloy_account_id.empty?
      h.content_tag :dd, h.link_to("Connect with Bongloy", bongloy_url, class: "btn btn-success btn-sm light-blue")
    else
      h.content_tag :dd, object.bongloy_account_id
    end
  end

  private

  def bongloy_url
    dashboard_bongloy_connects_authorize_path
    #"https://staging-sandbox.bongloy.com/oauth/authorize?client_id=#{ENV['CLIENT_ID']}&redirect_uri=https://4f5d3892.ngrok.io/dashboard%2Fbongloy_connects%2Fnew&response_type=code"
  end
end
