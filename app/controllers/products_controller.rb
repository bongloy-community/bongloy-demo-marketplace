class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id]).decorate
  end
end
