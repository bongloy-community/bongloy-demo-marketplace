require "rails_helper"

RSpec.describe Order, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:line_items) }
    it { is_expected.to belong_to(:user) }
  end

  describe "enum type" do
    it { is_expected.to define_enum_for(:status).with_values([:created, :succeeded]) }
  end
end
