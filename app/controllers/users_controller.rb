class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    StripeConnect.(current_user, params[:code]).connect if params[:code]
    @user = User.find(current_user.id).decorate
  end
end
