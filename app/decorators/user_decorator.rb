class UserDecorator < ApplicationDecorator
  include Rails.application.routes.url_helpers
  delegate_all

  def stripe_connect_account
    if object.stripe_account_id.nil? || object.stripe_account_id.empty?
      h.content_tag :dd, h.link_to("Connect with Stripe", stripe_url, class: "btn btn-success btn-sm light-blue")
    else
      h.content_tag :dd, object.stripe_account_id
    end
  end

  private

  def stripe_url
    # "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV['CLIENT_ID']}&scope=read_write"
    "https://staging-sandbox.bongloy.com/oauth/authorize?client_id=aSLmbR_PWt9wx1J5cbcrl1mKS1abwR7IrW7EfgoLivI&redirect_uri=https%3A%2F%2Ff5ea27cb.ngrok.io%2Fdashboard%2Fbongloy_connects%2Fnew&response_type=code"
  end
end
