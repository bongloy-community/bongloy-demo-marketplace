class UserDecorator < ApplicationDecorator
  delegate_all

  def stripe_connect_account
    if object.stripe_account_id.nil? || object.stripe_account_id.empty?
      h.content_tag :dd, h.link_to('Connect with Stripe', stripe_url, :class => "btn btn-success light-blue")
    else
      h.content_tag :dd, object.stripe_account_id
    end
  end

  private
  def stripe_url
    "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV['CLIENT_ID']}&scope=read_write"
  end
end
