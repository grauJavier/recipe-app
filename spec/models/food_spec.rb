# spec/models/food_spec.rb

require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(
      name: 'Test User',
      email: 'user@example.com',
      password: 'password123'
    )
    food = user.foods.new(
      name: 'Apple',
      measurement_unit: 'piece',
      price: 1,
      quantity: 10
    )
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    user = User.create(
      name: 'Test User',
      email: 'user@example.com',
      password: 'password123'
    )
    food = user.foods.new(
      measurement_unit: 'piece',
      price: 1,
      quantity: 10
    )
    expect(food).to_not be_valid
  end

  it 'is not valid without a measurement unit' do
    user = User.create(
      name: 'Test User',
      email: 'user@example.com',
      password: 'password123'
    )
    food = user.foods.new(
      name: 'Apple',
      price: 1,
      quantity: 10
    )
    expect(food).to_not be_valid
  end

  it 'is not valid without a price' do
    user = User.create(
      name: 'Test User',
      email: 'user@example.com',
      password: 'password123'
    )
    food = user.foods.new(
      name: 'Apple',
      measurement_unit: 'piece',
      quantity: 10
    )
    expect(food).to_not be_valid
  end

  it 'is not valid without a quantity' do
    user = User.create(
      name: 'Test User',
      email: 'user@example.com',
      password: 'password123'
    )
    food = user.foods.new(
      name: 'Apple',
      measurement_unit: 'piece',
      price: 1
    )
    expect(food).to_not be_valid
  end
end
