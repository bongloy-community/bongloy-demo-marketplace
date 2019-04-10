require "rails_helper"

RSpec.describe "Visitors", type: :feature do
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

    expect(page).to have_current_path(new_user_registration_path)
  end

  it "click the login link" do
    visit root_path
    click_on("Sign In")

    expect(page).to have_current_path(new_user_session_path)
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

    expect(page).to have_current_path(product_path(product))
    expect(page).to have_content(product.description)
  end

  it "click on buy button" do
    visit root_path
    click_on("Buy")

    expect(page).to have_current_path(new_product_charge_path(product))
    expect(page).to have_content("Payment Information")
  end

  describe "Search" do
    before do
      user = create(:user, shop_name: "Samsung Store", email: "service@samsung.com")
      create(:product, :with_cover_product, user_id: user.id, name: "samsung 10", price: 600)
      create(:product, :with_cover_product, user_id: user.id, name: "samsung 10+", price: 800)
    end

    it "match product" do

      visit root_path
      fill_in :search, with: "samsung"

      find(:css, 'i.fa.fa-search').click

      expect(page).to have_content("samsung 10")
      expect(page).to have_content("$600")
      expect(page).to have_content("$800")
    end

    it "doesn't match product", js: true do
      visit root_path
      fill_in :search, with: "hauwei"

      find(:css, 'i.fa.fa-search').click

      expect(page).to have_content("No search results found")
    end
  end
end
