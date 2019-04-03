class HomeController < ApplicationController
  def index
    @products = Product.all.decorate
  end

  def show
    @product = Product.find(params[:id])
  end
end
