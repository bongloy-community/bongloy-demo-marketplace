require "rails_helper"

RSpec.describe UserDecorator do
  context "when user haven't connect to stripe" do
    it "return Connect with Stripe button" do
      user = create(:user).decorate
      expect(user.stripe_connect_account).to have_content("Connect with Stripe")
    end
  end

  context "when user already connect to stripe" do
    it "return actual image if product image exist" do
      user = create(:user, stripe_account_id: "acct_12345678").decorate
      expect(user.stripe_connect_account).to have_content("acct_")
    end
  end
end
