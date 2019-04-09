class Dashboard::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[destroy update show edit]
  before_action :connect_to_stripe

  def index
    @product = current_user.products.decorate
  end

  def new
    @product = Product.new
  end

  def show; end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = "Your product was successfully created."
      redirect_to dashboard_products_path
    else
      render action: "edit"
    end
  end

  def destroy
    @product.destroy

    redirect_to dashboard_products_path
  end

  def edit
    @product = Product.find(params[:id]).decorate
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to dashboard_products_path, notice: "Product was successfully updated." }
        format.json { render :index, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_attachment
    @cover_product = Product.find(params[:id]).cover_product
    @cover_product.purge
  end

  private

  def set_product
    @product = current_user.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :cover_product).merge(user_id: current_user.id)
  end

  def connect_to_stripe
    unless current_user.stripe_account_id.present?
      redirect_to dashboard_users_path
    end
  end
end
