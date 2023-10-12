class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /recipe_foods/new
  def new
    @recipe_food = RecipeFood.new
    # List all the foods that the current user has except the ones that are already in the recipe
    @foods = current_user.foods.where.not(id: RecipeFood.where(recipe_id: params[:recipe_id]).pluck(:food_id))
  end

  # POST /recipe_foods
  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to @recipe_food, notice: 'Ingredient was successfully added to the recipe.'
    else
      render :new
    end
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity)
  end
end
