require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:shop_name) }
    it { is_expected.to validate_uniqueness_of(:shop_name) }
  end

  describe "associations" do
    it { is_expected.to have_many(:products) }
    it { is_expected.to have_many(:orders) }
  end
end
