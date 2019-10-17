Bongloy = Stripe

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.publishable_key,
  secret_key: Rails.application.credentials.secret_key
}

Bongloy.api_key =  Rails.application.credentials.secret_key

Bongloy.api_base = "https://api.bongloy.com"
Bongloy.connect_base = "https://sandbox.bongloy.com"

# Local

# Bongloy.api_base = "http://localhost:3000"
# Bongloy.connect_base = "http://localhost:3000"

# staging-sanbox
# Bongloy.api_base = "https://api-staging.bongloy.com"
# Bongloy.connect_base = "https://staging-sandbox.bongloy.com"
