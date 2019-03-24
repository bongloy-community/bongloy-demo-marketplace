class ProductsController < ApplicationController
  before_action :set_product, only: %i[destroy update show]

  def index
    @product = Product.where(user_id: current_user.id)
  end

  def new
    @product = Product.new
  end

  def show; end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = "Your product was successfully created."
      redirect_to products_path
    else
      render action: "edit"
    end
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  def edit
    @product = Product.with_attached_cover_product.where(id: params[:id]).where(user_id: current_user.id).first
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: "Product was successfully updated." }
        format.json { render :index, status: :ok, location: @product }
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
