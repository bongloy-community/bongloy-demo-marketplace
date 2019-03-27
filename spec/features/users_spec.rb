require "rails_helper"

RSpec.describe "Users", type: :feature do
  it "visitor register to the shop" do
    visit new_user_registration_path

    fill_in "user[email]", with: "phanna@bongloy.com"
    fill_in "user[password]", with: "12345678"
    fill_in "user[password_confirmation]", with: "12345678"
    fill_in "user[shop_name]", with: "testing shop"
    click_on("Create Account")

    expect(page).to have_current_path(root_path)
    expect(page).to have_link("Store", href: dashboard_products_path)
    expect(page).to have_link("My account", href: users_path)
  end

  it "visitor login to the app" do
    user = create(:user, email: "phanna@bongloy.com", password: "12345678")

    visit user_session_path

    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_on "Log in"

    expect(page).to have_current_path(root_path)
  end

  it "user logout their account" do
    user_signin
    visit destroy_user_session_path
    expect(page).to have_link("Register", href: new_user_registration_path)
  end

  context "when user already connected to stripe" do
    it "display stripe account id" do
      user = create(:user, email: "phanna@bongloy.com", password: "12345678", stripe_account_id: "acc_12345678")
      sign_in(user)
      visit users_path(user)

      expect(page).to have_content("acc_12345678")
    end
  end

  context "when user haven't connected to stripe yet" do
    it "display stripe account id" do
      user = create(:user, email: "phanna@bongloy.com", password: "12345678")
      sign_in(user)
      visit users_path(user)

      expect(page).to have_content("Connect with Stripe")
    end
  end

  it "can see only their own product" do
    user = create(:user)
    sign_in(user)
    product = create(:product, :with_cover_product, user_id: user.id, name: "Hauwei")
    visit dashboard_products_path

    expect(page).to have_content(product.name)
  end

  it "can link to create new product" do
    user_signin
    visit dashboard_products_path
    click_on "New"

    expect(page).to have_current_path(new_dashboard_product_path)
  end

  it "cannot see other seller product" do
    user = create(:user)
    other_user = create(:user, email: "other@example.com", shop_name: "other")

    sign_in(user)
    product = create(:product, :with_cover_product, user_id: other_user.id, name: "Hauwei")
    visit dashboard_products_path

    expect(page).not_to have_content(product.name)
  end

  it "user visit setting" do
    user_signin
    visit users_path

    expect(page).to have_content("phanna@bongloy.com")
    expect(page).to have_content("Mobile Shop")
  end

  def user_signin
    user = create(:user)
    sign_in(user)
  end
end
