FactoryBot.define do

  factory :user do
    email { "Plus" }
    shop_name { "Android" }
    encrypted_password { "12345678" }
  end

  factory :product do
    name { "OnePlust" }
    description { "new smart phone technology" }
    price { 200 }
  end
end
