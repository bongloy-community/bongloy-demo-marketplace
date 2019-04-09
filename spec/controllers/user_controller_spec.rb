require "rails_helper"
require "fake_stripe"

RSpec.describe Dashboard::UsersController, type: :controller do
  before do
    FakeStripe.stub_stripe
  end

  after do
    WebMock.reset!
    Stripe.api_key = Rails.application.secrets.stripe_secret_key
  end

  let!(:stripe_response) { ["stripe_user_id" => "acct_12345678"] }

  it "connect to stripe", :vcr do
    user = create(:user)
    sign_in user
    get :index, params: { code: "12345678" }

    res = stub_request(:post, "https://connect.stripe.com/oauth/token")
          .to_return(body: stripe_response, headers: { location: "http://localhost:3000/users" })

    expect(res.response.body).to eq(stripe_response)
    user.stripe_account_id = "acct_12345678"
    user.save!

    expect(user.stripe_account_id).to eq("acct_12345678")
    expect(response).to redirect_to(dashboard_users_path)
  end
end
