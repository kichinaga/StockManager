Rails.application.routes.draw do

  get 'companies/search' => 'companies#search'
  post 'companies/search' =>  'companies#search'

  resources :companies, only: [:index, :show]
  resources :industries, only: [:index]
  resources :markets, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
