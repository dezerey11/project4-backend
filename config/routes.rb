Rails.application.routes.draw do
  # make post routes
  resources :posts


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  ## to get all crud routes for the user model, only create create here though
  resource :users, only: [:create]

  # a post request for signup endpoint. It takes you to the user model and function create
  post "/signup", to: "users#create"

  # a post request for login endpoint. It takes you to the user model and function login
  post "/login", to: "users#login"

  # get request to test login
  get "/auto_login", to: "users#auto_login"
end
