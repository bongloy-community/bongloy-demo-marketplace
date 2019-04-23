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

    binding.pry

    response = HTTParty.post("https://connect.stripe.com/oauth/token", query: parameters)
  end
end
