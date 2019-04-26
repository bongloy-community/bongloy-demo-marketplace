require 'rails_helper'

RSpec.describe Deauthorize do
  describe "#run" do
    it "sets Stripe Account to nil for current user" do
      current_user = create(:user, stripe_account_id: "valid")

      workflow = described_class.new(user: current_user)

      allow(Deauthorize).to receive(:run).and_return(current_user)

      expect(current_user.stripe_account_id).to eq nil
    end
  end
end
