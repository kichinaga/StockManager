Rails.application.routes.draw do
  root 'home#index'

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'
  
  # get 'companies/search', to: 'companies#search'
  post 'companies/search', to: 'companies#search'

  resources :companies, only: [:index, :show]
  resources :industries, only: [:index]
  resources :markets, only: [:index]
  resources :users
  resources :stocks, only: [:show, :new, :create, :edit, :update, :destroy]

  ## api routing
  mount API::Root => '/'
end
