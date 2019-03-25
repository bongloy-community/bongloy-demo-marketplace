class HomeController < ApplicationController
  def home
    @products = Product.all
  end

  def index; end

  def show
    @product = Product.find(params[:id])
  end
end
