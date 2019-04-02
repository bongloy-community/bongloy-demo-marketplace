require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  WebMock.allow_net_connect!
  let!(:stripe_response) { [ "stripe_user_id" => "acct_12345678" ] }

  it "connect to stripe" do
    user = create(:user)
    sign_in user
    get :index, params: { code: "12345678" }

    res = stub_request(:post, 'https://connect.stripe.com/oauth/token')
      .to_return(:body => stripe_response, headers: { location: "http://localhost:3000/users" })

    expect(res.response.body).to eq(stripe_response)
    user.stripe_account_id = "acct_12345678"
    user.save!

    expect(user.stripe_account_id).to eq("acct_12345678")
    expect(response.body).to eq("Successfully")
  end
end
