class HomeController < ApplicationController
  def index
    @products = Product.all.decorate
    # @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
