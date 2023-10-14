# spec/integration/food_spec.rb
require 'rails_helper'

RSpec.describe 'foods/index.html.erb', type: :view do
  describe 'integration tests for foods page' do
    before(:each) do
      @user = User.create(name: 'Ruth', email: 'ruth@gmail.com', password: '7410')
      sign_in @user

      # Create test foods associated with the user
      @food1 = Food.create(name: 'pizza', user_id: @user.id, measurement_unit: 'grams', price: 10)
      @food2 = Food.create(name: 'burger', user_id: @user.id, measurement_unit: 'grams', price: 15)
      @food3 = Food.create(name: 'apple', user_id: @user.id, measurement_unit: 'grams', price: 20)

      # Stub the controller action to assign the @foods instance variable with the test foods data
      assign(:foods, [@food1, @food2, @food3])

      # Render the view
      render
    end

    it 'displays foods on the foods page' do
      expect(rendered).to have_content 'pizza'
      expect(rendered).to have_content 'burger'
      expect(rendered).to have_content 'apple'
    end
  end
end
