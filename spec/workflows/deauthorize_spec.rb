require 'rails_helper'

RSpec.describe Deauthorize do
  describe "#run" do
    let(:deauthorized) { instance_double(deauthorize_access) }
    it "sets Stripe Account to nil for current user" do
      current_user = create(:user)

      workflow = described_class.new(current_user)

      allow(workflow).to receive(:deauthorize_access).and_return({ stripe_user_id: "acct_12345678" })

      workflow.run

      expect(current_user.stripe_account_id).to eq nil
    end
  end
end
