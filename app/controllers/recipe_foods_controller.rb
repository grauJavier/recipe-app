class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /recipe_foods/new
  def new
    @recipe_food = RecipeFood.new
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
end
