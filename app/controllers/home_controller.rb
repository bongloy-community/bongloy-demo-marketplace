class HomeController < ApplicationController
  def index
    if params[:search]
      @products = Product.search(params[:search]).decorate
    else
      @products = Product.all.decorate
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
