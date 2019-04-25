require 'rails_helper'

RSpec.describe "Users", type: :feature do
  it "show their account setting" do
    user = create(:user, shop_name: "alibaba", email: "sovon@example.com")
    sign_in user

    visit dashboard_user_path(user)

    expect(page).to have_content(user.shop_name)
    expect(page).to have_content(user.email)
  end

  context "when user already connect to stripe" do
    it "display stripe_account_id" do
      user = create(:user, shop_name: "alibaba", email: "sovon@example.com")
      sign_in user

      visit dashboard_user_path(user)

      expect(page).to have_content(user.stripe_account_id)
    end
  end

  context "when user haven't connect to stripe yet" do
    it "display button connect to stripe" do
      user = create(:user, shop_name: "alibaba", email: "sovon@example.com", stripe_account_id: nil)
      sign_in user

      visit dashboard_user_path(user)

      expect(page).to have_content("Connect with Stripe")
    end
  end
end
