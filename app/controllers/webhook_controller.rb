class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def deauthorize
    if params[:type] == "account.application.deauthorized"
      user = User.find_by(bongloy_account_id: params[:account])

      user.bongloy_account_id = nil
      user.products.each { |q| q.update_attribute(:status, false) }

      user.save!
    end
  end
end
