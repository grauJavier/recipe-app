# spec/features/recipe_show_page_spec.rb
require 'rails_helper'

RSpec.describe 'Recipe Show Page', type: :feature do
  describe 'GET /recipes/:id' do
    user = User.create(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password123'
    )
    user.save
    # user.confirmed_at = Time.now
    recipe = Recipe.create(
      name: 'Fruit Salad',
      preparation_time: 10,
      cooking_time: 15,
      description: 'Healthy fruit salad recipe.',
      public: true,
      user_id: user.id
    )
    recipe.save
    # food = user.foods.create(name: 'Apple', measurement_unit: 'piece', price: 1, quantity: 10)
    # recipe = Recipe.create(
    #   name: 'Test Recipe',
    #   preparation_time: 10,
    #   cooking_time: 20,
    #   description: 'Test Recipe Description',
    #   public: true,
    #   user_id: user.id
    # )

    scenario 'displays the recipe name' do
      sign_in user
      visit recipe_path(recipe)
      expect(page).to have_content(recipe.name)
    end

    # scenario 'displays the recipe description' do
    #   visit recipe_path(recipe)
    #   expect(page).to have_content(recipe.description)
    # end

    # scenario 'displays the recipe preparation time' do
    #   visit recipe_path(recipe)
    #   expect(page).to have_content(recipe.preparation_time)
    # end

    # scenario 'displays the recipe cooking time' do
    #   visit recipe_path(recipe)
    #   expect(page).to have_content(recipe.cooking_time)
    # end

    # scenario 'displays the recipe public status' do
    #   visit recipe_path(@recipe)
    #   expect(page).to have_content(@recipe.public)
    # end

    # scenario 'displays the option to go to the shopping list' do
    #   visit recipe_path(@recipe)
    #   expect(page).to have_link('Go to shopping list')
    # end

    # scenario 'displays the option to add an ingredient' do
    #   visit recipe_path(@recipe)
    #   expect(page).to have_link('+ Add Ingredient')
    # end
  end
end
