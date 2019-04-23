class Charge
  PLATE_FORM_FEE_IN_CENTS = 100

  attr_accessor :order, :token

  def initialize(token:, order:)
    @order = order
    @token = token
  end

  def self.create(token:, order:)
    Charge.new(token: token, order: order).create
  end

  def create
    Stripe::Charge.create({
      amount: @order.total,
      currency: "usd",
      source: @token,
      application_fee_amount: PLATE_FORM_FEE_IN_CENTS,
      metadata: {
        order: @order.to_json,
        product: @order.product.to_json }
      },
      stripe_account: @order.user.stripe_account_id
    )
  end
end
