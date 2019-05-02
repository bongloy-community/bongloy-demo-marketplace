class StripeConnect
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def connect
    parameters = {
      client_secret: ENV.fetch("CLIENT_SECRET"),
      code: @code,
      grant_type: "authorization_code",
      client_id: ENV.fetch("CLIENT_ID"),
      redirect_uri: "https://f5ea27cb.ngrok.io/dashboard/bongloy_connects/new"
    }

    binding.pry

    response = HTTParty.post(ENV.fetch("STRIPE_CONNECT_URL"), query: parameters)
  end
end
