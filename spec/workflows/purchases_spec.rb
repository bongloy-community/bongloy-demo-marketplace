require "rails_helper"

RSpec.describe "Purchases", :vcr, :aggregate_failures do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, :with_cover_product, user_id: user.id) }
  let(:payment_processing) { Purchases.new(user: product.user, token: "token", product: product) }

  describe "payments" do
    before do
      stub_request(:any, "https://api-staging.bongloy.com/v1/tokens").and_return(body: "{}")
      stub_request(:post, "https://api-staging.bongloy.com/v1/charges").and_return(
        body: File.read(Rails.root.join("spec/fixtures/charge.succeeded.json")),
        status: 201,
        headers: { "Content-Type" => "application/json;charset=utf-8" }
      )

      payment_processing.run
    end

    it "create charge" do
      expect(WebMock).to have_requested(:post, "https://api-staging.bongloy.com/v1/charges").with { |request|
        payload = WebMock::Util::QueryMapper.query_to_values(request.body)
        expect(payload["source"]).to eq("token")
        expect(payload["amount"]).to eq("20000")
        expect(payload["currency"]).to eq("usd")
      }
    end
  end
end
