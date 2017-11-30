Rails.application.routes.draw do
  root 'home#index'

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'

  resources :companies , only: [:index, :show] do
    post :search, on: :collection
  end

  resources :industries, only: :index
  resources :markets, only: :index
  resource :users, except: :index
  resources :stocks, only: [:create, :destroy]
  resources :stock_lists, only: [:index, :show, :create]

  ## api routing
  mount API::Root => '/'
end
