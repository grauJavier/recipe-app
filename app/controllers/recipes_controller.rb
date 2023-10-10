class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
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
    params.require(:recipe).permit(:name, :ingredients, :cook_time)
  end
end

# ```
#
### Edit
#
# ```ruby
# Path: app/views/recipes/edit.html.erb
# <h1>Edit Recipe</h1>
#
# <%= form_for @recipe do |f| %>
#   <%= f.label :name %>
#   <%= f.text_field :name %><br>
#
#   <%= f.label :ingredients %>
#   <%= f.text_area :ingredients %><br>
#
#   <%= f.label :cook_time %>
#   <%= f.text_field :cook_time %><br>
#
#   <%= f.submit %>
# <% end %>
# ```
#
# ```ruby
# Path: app/controllers/recipes_controller.rb
# class RecipesController <p ApplicationController
#   def edit
#     @recipe = Recipe.find_by(id: params[:id])
#   end
#
#   def update
#     @recipe = Recipe.find_by(id: params[:id])
#     @recipe.update(recipe_params)
#     redirect_to recipe_path(@recipe)
#   end
# end
# ```
#
### Delete
#
# ```ruby
# Path: app/views/recipes/show.html.erb
# <h1><%= @recipe.name %></h1>
#
# <p><strong>Ingredients:</strong> <%= @recipe.ingredients %></p>
# <p><strong>Cook Time:</strong> <%= @recipe.cook_time %></p>
#
# <%= link_to "Edit Recipe", edit_recipe_path(@recipe) %>
# <%= link_to "Delete Recipe", recipe_path(@recipe), method: :delete, data: { confirm: "Are you sure?" } %>
# ```
