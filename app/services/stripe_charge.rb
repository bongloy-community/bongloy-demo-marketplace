class StripeCharge
  def charge
    Stripe::Charge.create({
      amount: @product.price_in_cents,
      currency: "usd",
      source: params[:stripeToken],
      application_fee_amount: 100,
    }, stripe_account: @product.user.stripe_account_id)
  end
end
