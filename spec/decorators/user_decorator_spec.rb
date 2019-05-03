require "rails_helper"

RSpec.describe UserDecorator do
  context "when user haven't connect to bongloy" do
    it "return Connect with Bongloy button" do
      user = create(:user, bongloy_account_id: nil).decorate
      expect(user.bongloy_connect_account).to have_content("Connect with Bongloy")
    end
  end

  context "when user already connect to bongloy" do
    it "return bongloy account id" do
      user = create(:user).decorate
      expect(user.bongloy_connect_account).to have_content("acct_12345678")
    end
  end
end
