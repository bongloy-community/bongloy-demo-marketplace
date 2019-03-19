class ProductsController < ApplicationController
  before_action :set_product, only: %i[destroy update edit]

  def index
    @product = Product.where(user_id: current_user.id)
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
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
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product}
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :cover_product).merge(user_id: current_user.id)
  end
end
