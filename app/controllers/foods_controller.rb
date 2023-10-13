class FoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /foods
  def index
    # Get all the food objects from the database
    @foods = current_user.foods
  end

  # GET /foods/:id
  def show
    # Find the food object with the given id
    @food = Food.find_by_id(params[:id])

    # If the food object is not found
    return unless @food.nil?

    # Set an error message
    flash[:alert] = 'Something went wrong! Food not found'
    # Redirect to the foods page
    redirect_to foods_path
  end

  # GET /foods/new
  def new
    # Create a new food object
    @food = Food.new
  end

  # POST /foods
  def create
    @food = Food.find_or_initialize_by(
      name: params[:food][:name],
      measurement_unit: params[:food][:measurement_unit],
      price: params[:food][:price],
      user_id: current_user.id
    )

    if @food.new_record?
      @food.user = current_user
      @food.quantity = params[:food][:quantity]
    else
      @food.quantity += params[:food][:quantity].to_i
    end

    if @food.save
      flash[:notice] = 'Food was successfully added to the list.'
      redirect_to foods_path
    else
      flash.now[:alert] = 'Something went wrong! Food was not added to the list.'
      render 'new'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    RecipeFood.where(food_id: @food.id).destroy_all

    if @food.destroy
      flash[:notice] = 'Food was successfully deleted.'
      redirect_to foods_path
    else
      flash.now[:alert] = 'Something went wrong! Food was not deleted.'
      render 'show'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
