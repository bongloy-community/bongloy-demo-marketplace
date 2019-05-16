class Dashboard::OrdersController < Dashboard::BaseController
  def index
    @orders = current_user.orders
  end
end
