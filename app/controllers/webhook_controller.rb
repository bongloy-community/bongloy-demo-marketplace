class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def deauthorize
    user = User.find_by(stripe_account_id: params[:account])
    user.deauthorize

  end
end
