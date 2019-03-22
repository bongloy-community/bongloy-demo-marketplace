require "rails_helper"

RSpec.describe Product, type: :model do
  describe "validations" do
    # it { is_expected.to validate_presence_of(:name) }
    # it { is_expected.to validate_presence_of(:price) }
  end

  describe "associations" do
    # it { is_expected.to belong_to(:user) }
  end

  describe "attachement" do
    # it "upload image with active storage" do
    #   subject.cover_product.attach(io: File.open(fixture_path + '/dummy_attachment.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg')
    #   expect(subject.cover_product).to be_attached
    # end
  end
end
