Rails.application.routes.draw do
  get 'home/index'

  # Authentication stuff
  match 'auth/:provider/callback', to: 'sessions#create', via: ['get', 'post']
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  get 'fuel', action: :show, controller: 'fuel'

  root 'home#index'
end
