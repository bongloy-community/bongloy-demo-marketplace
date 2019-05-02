Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
Stripe.api_key = ENV.fetch("SECRET_KEY")
Stripe.api_base = "https://api-staging.bongloy.com"
