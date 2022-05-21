Rails.application.routes.draw do
  get 'home/index'

  # Authentication stuff
  match 'auth/:provider/callback', to: 'sessions#create', via: ['get', 'post']
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  root 'home#index'
end
