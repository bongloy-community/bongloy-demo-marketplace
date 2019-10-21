require "rails_helper"

RSpec.describe Purchases, :vcr, :aggregate_failures do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, :with_cover_product, user_id: user.id) }
  let(:payment_processing) { Purchases.new(user: product.user, token: "token", product: product) }

  describe "payments" do
    it "create charge" do
      stub_request(:any, "https://api.bongloy.com/v1/tokens").and_return(body: "{}")
      charge = stub_request(:post, "https://api.bongloy.com/v1/charges").and_return(
        body: File.read(Rails.root.join("spec/fixtures/charge.succeeded.json")),
        status: 201,
        headers: { "Content-Type" => "application/json;charset=utf-8" }
      )

      payment_processing.run

      payload = JSON.parse(charge.response.body)

      expect(payload["amount"]).to eq(100)
      expect(payload["currency"]).to eq("usd")
    end
  end
end
