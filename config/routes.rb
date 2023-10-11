Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "home#index", as: "home"
  resources :users, only: %i[index show new create destroy]
  resources :recipes, only: %i[index show new create destroy]
  get '/public_recipe', to: 'recipes#public_recipe', as: 'public_recipe'
  get '/general_shopping_list', to: 'recipes#general_shopping_list', as: 'general_shopping_list'
  resources :foods, only: %i[index show new create destroy]
end
