require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "they see the link menu" do
    visit root_path
    
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Register")
    expect(page).to have_link href: new_user_session_path
    expect(page).to have_link href: user_session_path
  end

  scenario "they click the register link" do
    visit root_path
    click_on("Register")

    expect(current_path).to eq((new_user_registration_path))
  end

  scenario "they click the login link" do
    visit root_path
    click_on("Sign In")

    expect(current_path).to eq((new_user_session_path))
  end

  scenario "visitor register to the shop" do
    visit new_user_registration_path

    fill_in "user[email]", with: "phanna@bongloy.com"
    fill_in "user[password]", with: "12345678"
    fill_in "user[password_confirmation]", with: "12345678"
    fill_in "user[shop_name]", with: "testing shop"
    click_on("Create Account")

    expect(current_path).to eq(root_path)
    expect(page).to have_link("Store", :href => products_path)
    expect(page).to have_link("My account", :href => users_path)
  end

  scenario "visitor login to the app" do
    user = create(:user, email: "phanna@bongloy.com", password: "12345678")

    visit user_session_path
    
    fill_in "user[email]", with: "phanna@bongloy.com"
    fill_in "user[password]", with: "12345678"
    click_on "Log in"

    expect(current_path).to eq(root_path)
  end

  scenario "user logout their account" do
    visit destroy_user_session_path
    expect(page).to have_link("Register", :href => new_user_registration_path)
  end
end
