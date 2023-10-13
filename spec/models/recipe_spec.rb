# spec/models/recipe_spec.rb
require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password123') }
  let(:recipe) do
    user.recipes.create(name: 'Fruit Salad', preparation_time: 10, cooking_time: 15,
                        description: 'Healthy fruit salad recipe.', public: true)
  end

  before do
    User.destroy_all
    user.save
    user.confirm
  end

  it 'is valid with valid attributes' do
    expect(recipe).to be_valid
  end

  it 'is not valid without a name' do
    recipe.name = ''
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a preparation time' do
    recipe.preparation_time = 0
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a cooking time' do
    recipe.cooking_time = 0
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a description' do
    recipe.description = ''
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a user id' do
    recipe.user_id = nil
    expect(recipe).to_not be_valid
  end

  it 'is not valid with a name longer than 50 characters' do
    recipe.name = 'ThisIsANameThatIsTooLongToBeValidThisIsANameThatIsTooLongToBeValid'
    expect(recipe).to_not be_valid
  end

  it 'is not valid with a preparation time less than 0' do
    recipe.preparation_time = -10
    expect(recipe).to_not be_valid
  end

  it 'is not valid with a cooking time less than 0' do
    recipe.cooking_time = -10
    expect(recipe).to_not be_valid
  end

  it 'is not valid with a user id that does not exist' do
    recipe.user_id = 1000
    expect(recipe).to_not be_valid
  end
end
