require "rails_helper"

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    context "when user has authentication" do
      it "can access /products" do
        user = create(:user)
        sign_in(user)
        get(products_path)
        expect(response).to have_http_status(200)
      end

      it "display all their own product" do
        user = create(:user)
        products = create_list(:product, 2, :with_cover_product, user_id: user.id)

        sign_in(user)
        visit(products_path)

        expect(page).to have_content("OnePlus")
        expect(page).to have_content("smart phone")
      end
    end
  end
end
