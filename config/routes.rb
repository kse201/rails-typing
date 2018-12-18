Rails.application.routes.draw do
  resources :password_resets, only: %i[new create edit update]

  root to: 'static_pages#home'

  get '/home', to: 'static_pages#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get 'static_pages/help'
  get 'static_pages/about'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'users/new'

  resources :users

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  resources :account_activations, only: %i[edit]
  resources :microposts, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
end
