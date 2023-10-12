class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipe]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    # food that is related as an "ingredient"
    @recipe_foods = RecipeFood.where(recipe_id: params[:id])

    # If recipe has ingredients create an array with the ingredients
    if @recipe_foods.any?
      @ingredients = []
      @recipe_foods.each do |recipe_food|
        @ingredients << {
          name: Food.find_by(id: recipe_food.food_id).name,
          quantity: recipe_food.quantity,
          price: recipe_food.quantity * Food.find_by(id: recipe_food.food_id).price
        }
      end
    end

    return unless @recipe.nil?

    flash[:error] = 'Recipe not found'
    redirect_to recipes_path
  end

  def public_recipe
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render 'new', alert: 'Food was not created.'
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    RecipeFood.where(recipe_id: @recipe.id).destroy_all
    @recipe.destroy
    redirect_to recipes_path
  end

  def general_shopping_list
    # Current user food
    @user_foods = current_user.foods
    # Current user recipes
    @user_recipes = current_user.recipes.includes(:foods).where.not(foods: { id: nil })

    # If user have recipes and food generate the shopping list
    if @user_recipes.any? && @user_foods.any?
      @shopping_list = generate_general_shopping_list(@user_foods, @user_recipes)
      # total amount to spend on the purchase
      @total_price = @shopping_list.sum { |item| item[:price] }
      # total number of items to buy
      @total_items = @shopping_list.sum { |item| item[:quantity] }
    else
      # If there's no recipes and food items show a message and redirect to the recipes page
      flash[:error] = 'You need at least one recipe with ingredients to generate a shopping list.'
      redirect_to recipes_path
    end
  end

  private

  # method to generate the shopping list
  def generate_general_shopping_list(user_foods, user_recipes)
    @user_foods = user_foods
    @user_recipes = user_recipes
    # Current user shopping list
    @shopping_list = []
    # Iterate over the recipes
    @user_recipes.each do |recipe|
      # Iterate over the ingredients
      recipe.foods.each do |ingredient|
        # Get both quantities
        recipe_quantity = recipe.recipe_foods.find_by(food_id: ingredient.id).quantity
        available_quantity = @user_foods.find_by(id: ingredient.id).quantity

        # If user has the ingredient
        if @user_foods.include?(ingredient)
          # If there is less than needed for the recipe
          if available_quantity < recipe_quantity
            needed_quantity = recipe_quantity - available_quantity
            @shopping_list << generated_shopping_list_item(ingredient, needed_quantity)
          end

        else
          # If user doesn't have the food item
          @shopping_list << generated_shopping_list_item(ingredient, recipe_quantity)
        end
      end
    end
    # Send the shopping list
    @shopping_list
  end

  # method to generate the shopping list object
  def generated_shopping_list_item(ingredient, needed_quantity)
    {
      food: ingredient,
      quantity: needed_quantity,
      price: ingredient.price * needed_quantity
    }
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
