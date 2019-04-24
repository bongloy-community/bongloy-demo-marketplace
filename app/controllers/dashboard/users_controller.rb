class Dashboard::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id).decorate
  end
end
