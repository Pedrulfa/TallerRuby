Rails.application.routes.draw do
  
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
  get "/home" => "home#index", as: :home
end
