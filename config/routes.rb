Rails.application.routes.draw do
  get 'home/index'

  # Authentication stuff
  post 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  root 'home#index'
end
