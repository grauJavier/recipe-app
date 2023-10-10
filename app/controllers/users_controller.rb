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

  # GET /users/new
  def new
    # Create a new user object
    @user = User.new
  end

  # # POST /users
  def create
    # Create a new user object with the given params
    @user = User.new(user_params)
    # If the user object is saved to the database
    if @user.save
      # Redirect to the user's page
      redirect_to @user
    else
      # Otherwise, render the new user form again
      render 'new'
    end
  end

end
