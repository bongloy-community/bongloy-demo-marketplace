require 'rails_helper'

RSpec.describe Deauthorize do
  describe "#run" do
    it "set account to nil" do
    end

    it  "does not set acccount to nil" do
    end

    it "sets Stripe Account to nil for current user" do
      current_user = create(:user)

      workflow = described_class.new(current_user)

      allow(workflow).to receive(:deauthorize_access)
      workflow.run

      expect(current_user.stripe_account_id).to eq nil
    end
  end
end
