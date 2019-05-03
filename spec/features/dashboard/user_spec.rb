require "rails_helper"

RSpec.describe "Users", type: :feature do
  it "show their account setting" do
    user = create(:user, shop_name: "alibaba", email: "sovon@example.com")
    sign_in user

    visit dashboard_user_path(user)

    expect(page).to have_content(user.shop_name)
    expect(page).to have_content(user.email)
  end

  context "when user already connect to bongloy" do
    it "display bongloy_account_id" do
      user = create(:user, shop_name: "alibaba", email: "sovon@example.com")
      sign_in user

      visit dashboard_user_path(user)

      expect(page).to have_content(user.bongloy_account_id)
    end
  end

  context "when user haven't connect to bongloy yet" do
    it "display button connect to bongloy" do
      user = create(:user, shop_name: "alibaba", email: "sovon@example.com", bongloy_account_id: nil)
      sign_in user

      visit dashboard_user_path(user)

      expect(page).to have_content("Connect with Bongloy")
    end
  end
end
