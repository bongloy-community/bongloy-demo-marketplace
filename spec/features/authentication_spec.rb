require "rails_helper"

RSpec.describe "Authentication", type: :feature do
  it "register and create shop" do
    visit new_user_registration_path

    fill_in "user[email]", with: "phanna@bongloy.com"
    fill_in "user[password]", with: "12345678"
    fill_in "user[password_confirmation]", with: "12345678"
    fill_in "user[shop_name]", with: "testing shop"
    click_on("Create Account")

    expect(page).to have_current_path(root_path)
    expect(page).to have_link("Store", href: dashboard_products_path)
  end

  it "login to their shop" do
    user = create(:user, email: "phanna@bongloy.com", password: "12345678")

    visit user_session_path

    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_on "Log in"

    expect(page).to have_current_path(root_path)
  end

  it "user logout their account" do
    user = create(:user)
    sign_in user

    visit destroy_user_session_path

    expect(page).to have_link("Register", href: new_user_registration_path)
  end
end
