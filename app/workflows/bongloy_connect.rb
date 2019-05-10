class BongloyConnect
  include Rails.application.routes.url_helpers

  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def connect
    parameters = {
      client_secret: Rails.application.credentials.client_secret,
      code: @code,
      grant_type: "authorization_code",
      client_id: Rails.application.credentials.client_id,
      redirect_uri: new_dashboard_bongloy_connect_url
    }

    HTTParty.post(Rails.application.credentials.bongloy_connect_url,query: parameters)
  end
end
