class BongloyConnect
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
      redirect_uri: "#{ENV.fetch('BASE_URL')}/dashboard/bongloy_connects/new"
    }

    response = HTTParty.post(ENV.fetch("BONGLOY_CONNECT_URL"), query: parameters)
  end
end
