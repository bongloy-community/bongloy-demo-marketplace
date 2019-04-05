class Purchases
  attr_accessor :token, :success, :product, :order

  def initialize(user:, token:, product:)
    @token = token
    @success = false
    @product = product
    @user = user
  end

  def run
    Order.transaction do
      create_order
      charge
      @success = order.succeeded?
    end
  end

  def create_order
    self.order = Order.create!(order_attributes)
    order.create_line_item( { order_id: 1, product_id: @product.id, quantity: 1, price: @product.price })
  end

  def create_line_item
    order.create_line_item(line_item_attributes)
  end

  def order_attributes
    {user_id: @user.id, status: "created", total: @product.price_in_cents}
  end

  def charge
    charge = StripeCharge.charge(token: @token, order: @order)
    order.update!(charge_id: charge.id, payment_details: charge.to_json, status: charge.status)
  end

  def line_item_attributes
    { order_id: 1, product_id: @product.id, quantity: 1, price: @product.price }
  end
end
