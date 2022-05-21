Rails.application.routes.draw do
  get 'home/index'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/login', to: 'sessions#new'

  root 'home#index'
end
