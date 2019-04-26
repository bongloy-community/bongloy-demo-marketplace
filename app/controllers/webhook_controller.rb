class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def deauthorize
    user = User.find_by(stripe_account_id: params[:account])
    user.stripe_account_id = nil
    user.save
  end
end
