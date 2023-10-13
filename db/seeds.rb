# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb

user1 = User.create!(
    name: "User Test 1",
    email: "user1@example.com",
    password: "123456",
    confirmed_at: Time.now
  )
  
  user2 = User.create!(
    name: "User Test 2",
    email: "user2@example.com",
    password: "123456",
    confirmed_at: Time.now
  )
  
  food1 = user1.foods.create!(name: 'Apple', measurement_unit: 'piece', price: 1, quantity: 1)
  food2 = user1.foods.create!(name: 'Banana', measurement_unit: 'piece', price: 2, quantity: 2)
  
  food3 = user2.foods.create!(name: 'Orange', measurement_unit: 'piece', price: 1, quantity: 2)
  food4 = user2.foods.create!(name: 'Carrot', measurement_unit: 'piece', price: 1, quantity: 1)
  
  recipe1 = user1.recipes.create!(
    name: 'Fruit Salad',
    preparation_time: 10,
    cooking_time: 15,
    description: 'Healthy fruit salad recipe.',
    public: true
  )
  
  recipe2 = user2.recipes.create!(
    name: 'Carrot Soup',
    preparation_time: 15,
    cooking_time: 20,
    description: 'Delicious carrot soup recipe.',
    public: true
  )
  
  RecipeFood.create!(recipe: recipe1, food: food1, quantity: 3)
  RecipeFood.create!(recipe: recipe1, food: food2, quantity: 4)
  
  RecipeFood.create!(recipe: recipe2, food: food3, quantity: 4)
  RecipeFood.create!(recipe: recipe2, food: food4, quantity: 3)
  
  puts "Created seed data successfully!"
