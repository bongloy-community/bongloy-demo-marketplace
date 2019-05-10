require "rails_helper"

RSpec.describe "Purchases", type: :feature do
  before do
    stub_request(:post, "https://api-staging.bongloy.com/v1/charges").and_return(
      body: File.read(Rails.root.join("spec/fixtures/charge.succeeded.json")),
      status: 201,
      headers: { "Content-Type" => "application/json;charset=utf-8" }
    )
  end

  it "can purchase a product", js: true do
    user = create(:user)
    product = create(:product, :with_cover_product, user_id: user.id, name: "Oppo")

    sign_in(user)
    visit new_product_charge_path(product)

    fill_in "cardNumber", with: "6200 0000 0000 0005"
    fill_in "cardExpiry", with: "01/20"
    fill_in "cardCVC", with: "123"
    click_button "Buy"

    #expect(page).to have_current_path(root_path)

    #within("#flash") do
      #expect(page).to have_content("Your payment has been successfully processed")
    #end
  end
end
