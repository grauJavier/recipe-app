class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipe]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])

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
      redirect_to recipes_index_path, notice: 'Recipe was successfully created.'
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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
