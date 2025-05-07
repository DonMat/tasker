Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
  get "home/index"

  resource :session
  resources :passwords, param: :token
  resources :tasks

  namespace :v2 do
    resources :tasks, only: [ :index, :show, :create ]
  end

  mount API => "/"
end
