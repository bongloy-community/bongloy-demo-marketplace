class HomeController < ApplicationController
  def index
    if params[:search]
      @products = Product.search(params[:search])
    else
      @products = Product.buyable
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
