class ShoppingCart
  attr_accessor :user

  def initializer(user)
    @user = user
  end

  def products
    @products ||= user.product_in_cart
  end

  def total_price
    products.map(&:price).sum.to_money
  end
end
