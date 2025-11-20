Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Página principal
  root "home#index"

  # Para gestionar usuarios
  get '/users/new',    to: 'users#new',    as: :new_user
  post '/users',       to: 'users#create', as: :users
  get '/users/:id',    to: 'users#show',   as: :user
  get '/users/:id/edit', to: 'users#edit', as: :edit_user
  patch '/users/:id',  to: 'users#update'
  put '/users/:id',    to: 'users#update'

  # Para iniciar sesión
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show', as: :profile

end
