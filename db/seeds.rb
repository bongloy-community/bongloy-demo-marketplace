# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Product.delete_all

user = User.create(email: "test@example.com", shop_name: "Examples", password: "12345678")


product_names = ["huawei_p30", "iphone_10", "oneplus_5t", "oppo_f11", "samsung_s8", "redmi_not7", "vivo_y95", "pixel_3xl"]

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/products/#{file_name}.jpg"))
end

product_names.each do |name|
  product = Product.new
  product.cover_product.attach(io: seed_image(name), filename: name)
  product.name = name.titleize
  product.user_id = user.id
  product.price = rand(500..1000)
  product.description = "Product description #{name.titleize}"
  product.status = false
  product.save!
end
