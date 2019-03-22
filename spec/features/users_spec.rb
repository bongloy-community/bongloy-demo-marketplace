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

  end
end
