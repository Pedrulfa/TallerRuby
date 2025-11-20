Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # --- TU PARTE (STOREFRONT) ---
  resources :products, only: [:index, :show]
  root "products#index"
  # -----------------------------

  # --- PARTE DE TUS COMPAÑEROS ---
  get '/users/new',    to: 'users#new',    as: :new_user
  post '/users',       to: 'users#create', as: :users
  get '/users/:id',    to: 'users#show',   as: :user
  get '/users/:id/edit', to: 'users#edit', as: :edit_user
  patch '/users/:id',  to: 'users#update'
  put '/users/:id',    to: 'users#update'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show', as: :profile
end