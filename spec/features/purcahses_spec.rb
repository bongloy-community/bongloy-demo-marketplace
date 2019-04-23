require "rails_helper"
require "fake_stripe"

RSpec.describe "Purchases", type: :feature do
  fixtures :all

  let!(:user) { create(:user) }
  let!(:product) { create(:product, :with_cover_product, user_id: user.id, name: "Oppo") }

  before(:each) do
    FakeStripe.stub_stripe
  end

  it "can purchase a product", :js do
    sign_in(user)
    visit new_product_charge_path(product)
    
    expect(page).to have_content("Payment Information")

    fill_stripe_element("4242 4242 4242 4242", "12/20", "123")
  
    # assert flash message
    expect(page).to have_current_path(root_path)
  end

  def fill_stripe_element(card, exp, cvc)
    card_iframe = all('iframe')[0]
    exp_iframe = all('iframe')[1]
    cvc_iframe = all('iframe')[2]

    within_frame card_iframe do
      card.chars.each do |piece|
        find_field('cardnumber').send_keys(piece)
      end
    end

    within_frame exp_iframe do
      exp.chars.each do |piece|
        find_field('exp-date').send_keys(piece)
      end
    end

    within_frame cvc_iframe do
      cvc.chars.each do |piece|
        find_field('cvc').send_keys(piece)
      end
    end

    click_on "Pay"
  end
end

