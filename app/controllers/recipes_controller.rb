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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
