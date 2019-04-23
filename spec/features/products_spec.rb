require "rails_helper"

RSpec.describe "Products", type: :feature do
  let!(:user) { create(:user, stripe_account_id: "acct_12345678") }
  let!(:product) { create(:product, :with_cover_product, user_id: user.id, name: "Oppo") }

  before do
    sign_in(user)
  end

  it "list the product" do

    visit dashboard_products_path
    expect(page).to have_content("Oppo")
  end

  it "add new product" do
    visit new_dashboard_product_path

    fill_in "product[name]", with: "Samsung"
    fill_in "product[description]", with: "new smart phone comming"
    fill_in "product[price]", with: "500"
    page.attach_file("product_cover_product", "#{::Rails.root}/spec/fixtures/dummy_attachment.jpg")
    click_on "Create"

    expect(page).to have_current_path(dashboard_products_path)
  end

  it "dispaly edit product" do
    visit edit_dashboard_product_path(product)
    expect(page).to have_field("product[name]", with: "Oppo")
  end

  it "edit products" do
    visit edit_dashboard_product_path(product)
    fill_in "product[name]", with: "new Oppo"
    fill_in "product[description]", with: "new smart phone comming"
    fill_in "product[price]", with: "500"
    click_on "Update"

    expect(page).to have_current_path(dashboard_products_path)
    expect(page).to have_content("new Oppo")
  end

  it "delete product" do
    visit dashboard_products_path
    expect { click_link "x Remove" }.to change(Product, :count).by(-1)
  end
end
