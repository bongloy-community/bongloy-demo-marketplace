FactoryBot.define do
  factory :user do
    email { "phanna@bongloy.com" }
    shop_name { "Mobile Shop" }
    password { "12345678" }
  end

  factory :product do
    name { "OnePlus" }
    description { "smart phone" }
    price { 200 }
    trait :with_cover_product do
      after(:build) do |product|
        product.cover_product.attach(io: File.open(Rails.root.join("spec", "fixtures", "dummy_attachment.jpg")), filename: "dummy_attachment.jpg", content_type: "image/jpg")
      end
    end
  end
end
