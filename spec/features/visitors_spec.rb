require 'rails_helper'

RSpec.feature "Visitors", type: :feature do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, :with_cover_product, user_id: user.id) }

  it "see the link menu" do
    visit root_path
    
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Register")
    expect(page).to have_link href: new_user_session_path
    expect(page).to have_link href: user_session_path
  end

  it "click the register link" do
    visit root_path
    click_on("Register")

    expect(current_path).to eq((new_user_registration_path))
  end

  it "click the login link" do
    visit root_path
    click_on("Sign In")

    expect(current_path).to eq((new_user_session_path))
  end

  it "display the products by all sellers" do
    visit root_path

    expect(page).to have_content("OnePlus")
    expect(page).to have_content("200")
    expect(page).to have_content("Buy")
  end

  it "click on title to see detail" do
    visit root_path
    click_on(product.name)

    expect(current_path).to eq(product_path(product))
    expect(page).to have_content(product.description)
  end

  it "click on buy button" do
    visit root_path
    click_on("Buy")

    expect(current_path).to eq(new_product_charge_path(product))
    expect(page).to have_content("Payment information")
  end
end
