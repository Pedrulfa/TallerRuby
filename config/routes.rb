Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # --- TU PARTE (STOREFRONT) ---
  resources :products, only: [:index, :show, :new, :create]
  root "products#index"
  # -----------------------------

  # --- PARTE DE TUS COMPAÑEROS ---
  # Gestión de usuarios
  get '/users',        to: 'users#index',  as: :users_list  # Listado de usuarios
  get '/users/new',    to: 'users#new',    as: :new_user
  post '/users',       to: 'users#create', as: :users
  get '/users/:id',    to: 'users#show',   as: :user
  get '/users/:id/edit', to: 'users#edit', as: :edit_user
  patch '/users/:id',  to: 'users#update'
  put '/users/:id',    to: 'users#update'

  # Ruta para modificar rol de usuario
  patch '/users/:id/update_role', to: 'users#update_role', as: :update_user_role

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show', as: :profile
end