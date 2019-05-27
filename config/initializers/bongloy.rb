Bongloy = Stripe

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.publishable_key,
  secret_key: Rails.application.credentials.secret_key
}

Bongloy.api_key =  Rails.application.credentials.secret_key
Bongloy.api_base = "https://api.bongloy.com"
Bongloy.connect_base = "https://sandbox.bongloy.com"
