Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Página principal
  root "home#index"

  # Para gestionar usuarios
  resources :users, only: [:new, :create]

  # Para iniciar sesión
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
