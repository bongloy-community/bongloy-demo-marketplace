require "rails_helper"
require "fake_stripe"

RSpec.describe "Purchases", :vcr, :aggregate_failures do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, :with_cover_product, user_id: user.id) }
  let(:payment_processing) { Purchases.new(user: user, token: token, product: product) }

  before(:each) do
    FakeStripe.stub_stripe
  end
  
  describe "create payment" do
    let(:token) { Stripe::Token.create }

    before(:example) do
      payment_processing.run
    end

    it "create charge" do
      expect(payment_processing.order).to have_attributes(
        status: "succeeded", charge_id: a_string_starting_with("ch_"),
        payment_details: payment_processing.order.payment_details
      )
    end
  end
end
