require "rails_helper"
require "fake_stripe"

RSpec.describe Dashboard::BongloyConnectsController, type: :controller do
  before do
    FakeStripe.stub_stripe
  end

  after do
    WebMock.reset!
    Stripe.api_key = Rails.application.secrets.stripe_secret_key
  end

  let!(:stripe_response) { ["stripe_user_id" => "acct_12345678"] }

  it "connect to stripe" do
    user = create(:user)
    sign_in user

    bongloy_connects = described_class.new
    allow_any_instance_of(Dashboard::BongloyConnectsController).to receive(:current_user).and_return(user)

    expect(bongloy_connects).to receive(:get_stripe_user_data).and_return({stripe_user_id: "acct_12345678"})
    binding.pry
    bongloy_connects.new

    expect(response).to redirect_to(dashboard_user_path(user))
  end
end
