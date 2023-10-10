class FoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /foods
  def index
    # Get all the food objects from the database
    @foods = Food.all
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
    # Create a new food object with the given params
    @food = Food.new(food_params)
    # If the food object is saved to the database
    if @food.save
      # Redirect to the food's page
      redirect_to @food
    else
      # Otherwise, render the new food form again
      render 'new'
    end
  end

  # DELETE /foods/:id
  def destroy
    # Find the food object with the given id
    @food = Food.find(params[:id])
    # Delete the food object from the database
    @food.destroy
    # Redirect to the foods page
    redirect_to foods_path
  end
end
