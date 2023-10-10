class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
    @user = User.find_by_id(params[:id])

    return unless @user.nil?

    flash[:error] = 'User not found'
    redirect_to users_path
  end
end
