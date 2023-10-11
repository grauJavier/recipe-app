class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipe]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  def public_recipe
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def general_shopping_list
    # Current user recipes
    @user_recipes = current_user.recipes
    # Current user food
    @user_foods = current_user.foods
    # total amount to spend on the purchase
    @total_price = 0
    # total number of items to buy
    @total_items = 0
    # Current user shopping list
    @shopping_list = []
    # If user have recipes and food items start the process
    if @user_recipes.any? && @user_foods.any?
      # Iterate over the recipes
      @user_recipes.each do |recipe|
        # Iterate over the ingredients
        recipe.foods.each do |ingredient|
          # If user has the ingredient
          if @user_foods.include?(ingredient)
            # Get both quantities
            recipe_quantity = recipe.recipe_foods.find_by(food_id: ingredient.id).quantity
            available_quantity = @user_foods.find_by(id: ingredient.id).quantity

            # If there is less than needed for the recipe
            if available_quantity < recipe_quantity
              needed_quantity = recipe_quantity - available_quantity

              @shopping_list << {
                food: ingredient,
                quantity: needed_quantity,
                price: ingredient.price * needed_quantity
              }
              # Add the price to spend to the total amount to spend
              @total_price += ingredient.price * needed_quantity
              # Add 1 more item to the total number of items to buy
              @total_items += 1
            end

          else
            # If user doesn't have the food item
            @shopping_list << {
              food: ingredient,
              quantity: recipe_quantity,
              price: ingredient.price * recipe_quantity
            }
            # Add the price to spend to the total amount to spend
            @total_price += ingredient.price * recipe_quantity
            # Add 1 more item to the total number of items to buy
            @total_items += 1
          end
        end
      end
    else
      # If there's no recipes and food items show a message and redirect to the recipes page
      flash[:error] = 'You need at least one recipe and at least one ingredient related to the recipe in order to generate a shopping list.'
      redirect_to recipes_path
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :cook_time)
  end
end
