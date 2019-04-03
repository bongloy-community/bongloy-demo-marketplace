class ChargesController < ApplicationController
  before_action :set_product, only: %i[new create]

  def new; end

  def create
    payment_processing = Purchases.new(user: current_user, token: params[:stripeToken], product: @product)
    payment_processing.run
   
    if payment_processing.success
      flash[:payment_alert] = "Your payment has been successfully processed"
      redirect_to root_path()
    else
      flash[:payment_alert] = "Something went wrong in your payment"
      redirect_to new_product_charge_path(params[:product_id])
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
