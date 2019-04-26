class Dashboard::OrdersController < Dashboard::BaseController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
