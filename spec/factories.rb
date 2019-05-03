FactoryBot.define do
  factory :user do
    email { "phanna@bongloy.com" }
    shop_name { "Mobile Shop" }
    password { "12345678" }
    bongloy_account_id { "acct_12345678" }
  end

  factory :order do
    charge_id { "ch_12345" }
    status { "succeeded" }
  end

  factory :line_item do
    quantity { "1" }
  end

  factory :product do
    name { "OnePlus" }
    description { "smart phone" }
    price { 200 }
    status { false }
    trait :with_cover_product do
      after(:build) do |product|
        product.cover_product.attach(io: File.open(Rails.root.join("spec", "fixtures", "dummy_attachment.jpg")), filename: "dummy_attachment.jpg", content_type: "image/jpg")
      end
    end
  end
end
