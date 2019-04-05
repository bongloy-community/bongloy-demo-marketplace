class StripeCharge
  attr_accessor :order, :token

  def initialize(token:, order:)
    @order = order
    @token = token
  end

  def self.charge(token:, order:)
    StripeCharge.new(token: token, order: order).charge
  end

  def charge
    Stripe::Charge.create({
      amount: @order.total,
      currency: "usd",
      source: @token,
      application_fee_amount: 100,
      metadata: {reference: @order.charge_id}
      },
      stripe_account: @order.user.stripe_account_id
    )
  end
end
