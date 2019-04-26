class Dashboard::UsersController < Dashboard::BaseController
  def show
    @user = User.find(current_user.id).decorate
  end
end
