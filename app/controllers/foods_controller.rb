class FoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /foods
  def index
    # Get all the food objects from the database that belong to the current user
    @foods = current_user.foods
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
    @food = Food.find_or_create_by(
      name: params[:food][:name],
      measurement_unit: params[:food][:measurement_unit],
      price: params[:food][:price],
      user_id: current_user.id
    )
    # Update the quantity of the food object
    @food.quantity += params[:food][:quantity].to_i
    if @food.save
      redirect_to foods_path
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
