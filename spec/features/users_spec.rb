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
    expect(page).to have_link("Store", href: products_path)
    expect(page).to have_link("My account", href: users_path)
  end

  it "visitor login to the app" do
    user = create(:user, email: "phanna@bongloy.com", password: "12345678")

    visit user_session_path

    fill_in "user[email]", with: "phanna@bongloy.com"
    fill_in "user[password]", with: "12345678"
    click_on "Log in"

    expect(page).to have_current_path(root_path)
  end

  it "user logout their account" do
    user_signin
    visit destroy_user_session_path
    expect(page).to have_link("Register", href: new_user_registration_path)
  end

  it "can see only their own product" do
    user = create(:user)
    sign_in(user)
    product = create(:product, :with_cover_product, user_id: user.id, name: "Hauwei")
    visit products_path

    expect(page).to have_content("Hauwei")
  end

  it "cannot see other seller product" do
    user = create(:user)
    other_user = create(:user, email: "other@example.com", shop_name: "other")

    sign_in(user)
    product = create(:product, :with_cover_product, user_id: other_user.id, name: "Hauwei")
    visit products_path

    expect(page).not_to have_content("Hauwei")
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