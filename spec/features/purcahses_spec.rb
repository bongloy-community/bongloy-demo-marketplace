require "rails_helper"

RSpec.describe "Purchases", type: :feature do
  before do
    stub_request(:any, "https://api-staging.bongloy.com/v1/tokens").and_return(body: "{}")
    stub_request(:post, "https://api-staging.bongloy.com/v1/charges").and_return(
      body: File.read(Rails.root.join("spec/fixtures/charge.succeeded.json")),
      status: 201,
      headers: { "Content-Type" => "application/json;charset=utf-8" }
    )
  end

  it "can purchase a product", js: true do
    user = create(:user)
    product = create(:product, :with_cover_product, user_id: user.id, name: "Oppo")

    visit new_product_charge_path(product)

    find('#cardNumber').set('6200 0000 0000 0005')
    find('#cardExpiry').set('01/20')
    find('#cardCVC').set('123')
    click_button "Buy"

    expect(page).to have_current_path(root_path)
    expect(page).to have_content("Your payment has been successfully processed")
  end
end
