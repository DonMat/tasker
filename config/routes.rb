Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
  get "home/index"

  resource :session
  resources :passwords, param: :token
  resources :tasks

  mount API => "/"
end
