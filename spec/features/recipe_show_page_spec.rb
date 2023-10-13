# spec/features/recipe_show_page_spec.rb
require 'rails_helper'

RSpec.describe 'Recipe Show Page', type: :feature do
  describe 'GET /recipes/:id' do
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password123') }
    let(:recipe) do
      user.recipes.create(name: 'Fruit Salad', preparation_time: 10, cooking_time: 15,
                          description: 'Healthy fruit salad recipe.', public: true)
    end

    before do
      User.destroy_all
      user.save
      user.confirm
      sign_in user
    end

    scenario 'displays the recipe name' do
      recipe.save
      visit recipe_path(recipe)
      expect(page).to have_content(recipe.name)
    end

    scenario 'displays the recipe description' do
      visit recipe_path(recipe)
      expect(page).to have_content(recipe.description)
    end

    scenario 'displays the recipe preparation time' do
      visit recipe_path(recipe)
      expect(page).to have_content(recipe.preparation_time)
    end

    scenario 'displays the recipe cooking time' do
      visit recipe_path(recipe)
      expect(page).to have_content(recipe.cooking_time)
    end

    scenario 'displays the recipe public status' do
      visit recipe_path(recipe)

      expect(page).to have_content('Public')

      checkbox = find("input[type='checkbox'][disabled]")
      expect(checkbox).to be_checked if recipe.public
      expect(checkbox).not_to be_checked unless recipe.public
    end

    scenario 'displays the option to go to the shopping list' do
      visit recipe_path(recipe)
      expect(page).to have_link('Go to my Shopping List')
    end

    scenario 'displays the option to add an ingredient' do
      visit recipe_path(recipe)
      expect(page).to have_link('+ Add Ingredient')
    end
  end
end
