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
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to foods_index_path, notice: 'Food was successfully created.'
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
