Bongloy = Stripe

Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}

Bongloy.api_key = ENV.fetch("SECRET_KEY")
Bongloy.api_base = "https://api-staging.bongloy.com"
Bongloy.connect_base = "https://staging-sandbox.bongloy.com"
