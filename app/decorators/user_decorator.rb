class UserDecorator < ApplicationDecorator
  include Rails.application.routes.url_helpers
  delegate_all

  def bongloy_connect_account
    if object.bongloy_account_id.nil? || object.bongloy_account_id.empty?
      h.content_tag :dd, h.link_to("Connect with Bongloy", dashboard_bongloy_connects_authorize_path, class: "btn btn-success btn-sm light-blue")
    else
      h.content_tag :dd, object.bongloy_account_id
    end
  end
end
