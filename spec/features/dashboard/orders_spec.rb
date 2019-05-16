require "rails_helper"

RSpec.describe "Orders", type: :feature do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, :with_cover_product, user_id: user.id, price: 800) }
  let!(:order) { create(:order, user_id: user.id , total: product.price_in_cents)}
  let!(:line_items) { create(:line_item, order_id: order.id, product_id: product.id, price: product.price_in_cents) }

  it "list order history" do
    sign_in user
    visit dashboard_orders_path

    expect(page).to have_content("succeeded")
    expect(page).to have_content("ch_")
    expect(page).to have_content("800")
  end
end
