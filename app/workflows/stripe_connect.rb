class StripeConnect
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def connect
    parameters = {
      client_secret: ENV.fetch("SECRET_KEY"),
      code: @code,
      grant_type: "authorization_code"
    }

    response = HTTParty.post(ENV.fetch("STRIPE_CONNECT_URL"), query: parameters)
  end
end
