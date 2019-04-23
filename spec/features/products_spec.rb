require "rails_helper"

RSpec.describe "Products", type: :feature do

  it "list products" do
    user = create(:user)
    product = create(:product, :with_cover_product, user_id: user.id, price: 200)

    visit root_path

    expect(page).to have_content("$200")
    expect(page).to have_link("OnePlus", href: product_path(product))
    expect(page).to have_link("Buy", href: new_product_charge_path(product))
  end

  it "show product" do
    user = create(:user)
    product = create(:product, :with_cover_product, user_id: user.id, price: 200)

    visit product_path(product)

    expect(page).to have_content(product.price)
    expect(page).to have_content(product.description)
  end
end
