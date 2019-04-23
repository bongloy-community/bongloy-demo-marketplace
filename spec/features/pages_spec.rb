require "rails_helper"

RSpec.describe "Pages", type: :feature do
  it "display menu" do
    visit root_path

    expect(page).to have_link  "Sign In", href: new_user_session_path
    expect(page).to have_link "Register", href: new_user_registration_path
  end

  describe "Search" do
    before do
      user = create(:user, shop_name: "Samsung Store", email: "service@samsung.com")
      create(:product, :with_cover_product, user_id: user.id, name: "samsung 10", price: 600)
      create(:product, :with_cover_product, user_id: user.id, name: "samsung 10+", price: 800)
    end

    it "match product" do
      visit root_path

      fill_in :search, with: "samsung"
      click_on 'search'

      expect(page).to have_content("samsung")
      expect(page).to have_content("$600")
      expect(page).to have_content("$800")
    end

    it "doesn't match product", :js do
      visit root_path

      fill_in :search, with: "hauwei"
      click_on 'search'

      expect(page).to have_content("No search results found")
    end
  end
end
