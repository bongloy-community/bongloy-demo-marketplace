class HomeController < ApplicationController
  def home
    @products = Product.all
  end

  def index; end
end
