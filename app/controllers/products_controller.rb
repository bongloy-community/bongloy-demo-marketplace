class ProductsController < ApplicationController
  def show
    @product = Product.buyable.find_by(id: params[:id])

    redirect_to root_path unless @product
  end
end
