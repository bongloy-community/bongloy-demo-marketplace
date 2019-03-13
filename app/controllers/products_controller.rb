class ProductsController < ApplicationController
  before_action :set_product, only: %i[destroy update edit]

  def index
    @product = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = 'Your product was successfully created.'
      redirect_to products_path
    else
      render action: 'edit'
    end
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:notice] = 'Your product was successfully updated.'
      redirect_to products_path
    end
    render action: 'edit'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :image).merge(user_id: current_user.id)
  end
end
