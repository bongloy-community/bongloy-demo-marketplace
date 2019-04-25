require 'rails_helper'

RSpec.describe Deauthorize do
  describe "#run" do
    it "sets Stripe Account to nil for current user" do
      current_user = create(:user, stripe_account_id: "valid")
      #stub valid response / fake stripe
      
      #execute
      workflow = described_class.new(current_user)
      workflow.run

      expect(current_user.stripe_ccount).to eq nil
    end
  end
end

class Deauthorize
  def run
  end
end
