Rails.application.routes.draw do
  
  get "up" => "rails/health#show", as: :rails_health_check

  get "/home" => "home#index", as: :home
end
