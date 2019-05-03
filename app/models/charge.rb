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
    Bongloy::Charge.create({
      amount: @order.total,
      currency: "usd",
      source: @token,
      metadata: {
        order: @order.to_json,
        product: @order.product.to_json }
      },
      bongloy_account: @order.user.bongloy_account_id
    )
  end
end
