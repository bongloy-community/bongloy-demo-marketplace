require "rails_helper"

RSpec.describe "Products", type: :feature do

  it "list buyable products" do
    user = create(:user)
    product = create(:product, :with_cover_product, user_id: user.id, name: "Hauwei")
    buyable_product = create(:product, :with_cover_product, user_id: user.id, name: "Sony", status: true)

    visit root_path

    expect(page).to have_link("Sony", href: product_path(buyable_product))
    expect(page).to have_link("Buy", href: new_product_charge_path(buyable_product))
    expect(page).not_to have_content("Hauwei")
  end

  it "show product" do
    user = create(:user)
    product = create(:product, :with_cover_product, user_id: user.id, price: 200, status: true)

    visit product_path(product)

    expect(page).to have_content(product.price)
    expect(page).to have_content(product.description)
  end

  it "cannot show product" do
    user = create(:user)
    product = create(:product, :with_cover_product, user_id: user.id)

    visit product_path(product)

    expect(current_path).to eq(root_path)
  end
end
