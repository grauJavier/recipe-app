class RecipeFoodsController < ApplicationController
  # GET /recipe_foods/new
  def new
    @recipe_food = RecipeFood.new
  end

  # POST /recipe_foods
  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to @recipe_food, notice: 'Recipe food was successfully created.'
    else
      render :new
    end
  end
end
