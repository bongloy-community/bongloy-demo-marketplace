class ChargesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
  end

  def create; end
end
