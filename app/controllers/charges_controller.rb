class ChargesController < ApplicationController
  before_action :set_product, only: %i[new create]
  skip_before_action :verify_authenticity_token, :only => [:index, :new, :create]

  def new; end

  def create
    #customer = Stripe::Customer.create(
            #:email => params[:stripeEmail],
            #:source  => params[:stripeToken]
    #)
    #

    charge = Stripe::Charge.create(
      source: params[:stripeToken],
      amount: @product.price_in_cents,
      description: @product.description.to_s,
      currency: "USD",
      destination: {
        amount: (@product.price_in_cents * 0.9).to_i,
        account: @product.user.stripe_account_id
      }
    )
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
