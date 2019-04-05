require "rails_helper"

RSpec.describe ProductDecorator do
  it "return placeholder if image is nil" do
    user = create(:user)
    product = create(:product, user_id: user.id, name: "Oppo").decorate
    expect(product.image).to eq("https://via.placeholder.com/150")
  end
  
  it "return actual image if product image exist" do
    user = create(:user)
    product = create(:product, :with_cover_product, user_id: user.id, name: "Oppo").decorate
    expect(product.image).to eq(product.cover_product)
  end
end
