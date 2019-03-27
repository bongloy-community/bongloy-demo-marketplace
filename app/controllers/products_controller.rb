class ProductsController < ApplicationController

  def index
    @product = Product.all.decorate
  end

  def show
    @product = Product.find(params[:id]).decorate
  end
end
