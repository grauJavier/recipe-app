# spec/features/food_inventory_page_spec.rb
require 'rails_helper'

RSpec.describe 'Food Inventory Page', type: :feature do
  describe 'GET /food_inventory' do
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password123') }

    before do
      User.destroy_all
      user.save
      user.confirm
      sign_in user
    end

    scenario 'displays the food inventory page title' do
      visit foods_path
      expect(page).to have_content('Food Inventory')
    end

    scenario 'displays the option to add a new food item' do
      visit foods_path
      expect(page).to have_link('+ Add New Food', href: new_food_path)
    end

    context 'when food items exist' do
      let!(:food_items) do
        [
          user.foods.create(name: 'Apple', measurement_unit: 'piece', price: 1, quantity: 1),
          user.foods.create(name: 'Banana', measurement_unit: 'piece', price: 2, quantity: 2)
        ]
      end

      scenario 'displays the food items in the table' do
        visit foods_path
        food_items.each do |food|
          expect(page).to have_content(food.name)
          expect(page).to have_content(food.quantity)
          expect(page).to have_content(food.measurement_unit)
          expect(page).to have_content(food.price)
        end
      end

      scenario 'displays the delete button for each food item' do
        visit foods_path
        food_items.each do |_food|
          expect(page).to have_button('Delete', count: food_items.count)
        end
      end
    end

    scenario 'displays a message when there are no food items' do
      visit foods_path
      expect(page).to have_content("You haven't added any food yet.")
    end
  end
end
