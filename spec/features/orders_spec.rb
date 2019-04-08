require "rails_helper"

RSpec.describe "Orders", type: :feature do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, :with_cover_product, user_id: user.id, price: 800, name: "Samsung 10+") }
  let!(:order) { create(:order, user_id: user.id , total: product.price)}
  let!(:line_items) { create(:line_item, order_id: order.id, product_id: product.id, price: product.price) }

  let(:payment_processing) { Purchases.new(user: product.user, token: token, product: product) }

  before(:each) do
    FakeStripe.stub_stripe
  end

  it "list order history" do
    sign_in user

    visit dashboard_orders_path

    expect(page).to have_content("succeeded")
    expect(page).to have_content("ch_")
  end


  describe "create payment" do
    let(:token) { Stripe::Token.create }

    before(:example) do
      payment_processing.run
    end

    it "can show order" do
      sign_in user

      visit dashboard_order_path(order)

      #expect(page).to have_content("Visa")
      #expect(page).to have_content("4242")
      #expect(page).to have_content("100")
      #expect(page).to have_content("succeeded")
      #expect(page).to have_content("Samsung S10+")
      #expect(page).to have_content("$800")
      #expect(page).to have_content(order.created_at)
    end
  end
end
