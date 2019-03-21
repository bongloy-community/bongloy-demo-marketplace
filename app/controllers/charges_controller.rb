class ChargesController < ApplicationController
  before_action :set_product, only: %i[new create]

  def new; end

  def create

    charge = Stripe::Charge.create(
      :source => params[:token],
      :amount      => @product.price,
      :description => "#{@product.description}",
      :currency    => 'USD',
      :destination => {
        :amount => @product.price,
        :account => @product.user.stripe_user_id,
      }
    )
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
