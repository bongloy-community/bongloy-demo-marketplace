class BongloyConnect
  attr_accessor :code, :redirected_url

  def initialize(code, redirected_url)
    @code = code
    @redirected_url = redirected_url
  end

  def connect
    parameters = {
      client_secret: Rails.application.credentials.client_secret,
      code: @code,
      grant_type: "authorization_code",
      client_id: Rails.application.credentials.client_id,
      redirect_uri: @redirected_url
    }

    HTTParty.post(Rails.application.credentials.bongloy_connect_url,query: parameters)
  end
end
