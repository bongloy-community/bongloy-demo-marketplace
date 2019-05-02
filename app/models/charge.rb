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
    # binding.pry
    result = Stripe::Charge.create({
      amount: @order.total,
      currency: "usd",
      source: @token,
      metadata: {
        order: @order.to_json,
        product: @order.product.to_json }
      },
      bongloy_account: @order.user.stripe_account_id
    )
   # paramters = { 
   #    amount: @order.total,
   #    currency: "USD",
   #    source: @token
   # }
  # result = HTTParty.post(
   #   "https://api-staging.bongloy.com/v1/charges",
   #   body: paramters,
   #   headers: {
   #              "Http-Bongloy-Account" => @order.user.stripe_account_id,
   #              authorization: "Bearer sk_test_-V19hpX5OzJgKDCAfmw8C9MGNqLKdDuxoxobSiQq3ds"
   #  }
   # )
   binding.pry
  end
end
                # "BONGLOY_ACCOUNT" => @order.user.stripe_account_id,
