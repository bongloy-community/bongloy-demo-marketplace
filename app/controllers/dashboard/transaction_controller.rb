class Dashboard::TransactionController < ApplicationController
  def index
    @product = Product.find(6)
  end
end
