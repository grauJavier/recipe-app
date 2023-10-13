class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /recipe_foods/new
  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    # List all the foods that the current user has except the ones that are already in the recipe
    @foods = current_user.foods.where.not(id: @recipe.recipe_foods.pluck(:food_id))
  end

  # POST /recipe_foods
  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_food][:recipe_id]

    if @recipe_food.save
      flash[:notice] = 'Ingredient was successfully added to the recipe.'
      redirect_to recipe_path(@recipe_food.recipe_id)
    else
      flash.now[:alert] = 'Something went wrong! Ingredient was not added to the recipe.'
      render :new
    end
  end

  # DELETE /recipe_foods/:id
def destroy
  @recipe_food = RecipeFood.find(params[:id])
  @recipe = Recipe.find(@recipe_food.recipe_id)

  if @recipe_food.destroy
    flash[:notice] = 'Ingredient was successfully removed from the recipe.'
  else
    flash[:alert] = 'Something went wrong! Ingredient was not removed from the recipe.'
  end

  redirect_to recipe_path(@recipe.id)
end


  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
