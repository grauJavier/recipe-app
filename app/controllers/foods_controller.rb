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
    flash[:error] = 'Food not found'
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
    # If the food already exists with the same name, measurement_unit, price and created by same user
    # update the quantity otherwise create a new food object
    @food = Food.find_or_initialize_by(
      name: params[:food][:name],
      measurement_unit: params[:food][:measurement_unit],
      price: params[:food][:price],
      user_id: current_user.id
    )

    if @food.new_record?
      # If the food is a new record, it means it doesn't exist, so set the user and quantity
      @food.user = current_user
      @food.quantity = params[:food][:quantity]
    else
      # If the food already exists, update its quantity
      @food.quantity += params[:food][:quantity].to_i
    end
    
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render 'new', alert: 'Food was not created.'
    end
  end

  # DELETE /foods/:id
  def destroy
    @food = Food.find(params[:id])
    RecipeFood.where(food_id: @food.id).destroy_all
    @food.destroy
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
