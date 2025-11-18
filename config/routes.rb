Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: "admins/registrations", sessions: "admins/sessions" }
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  namespace :admins do
    root 'accommodations#index'
    resources :accommodations, only: %i[index show new create edit update destroy] do
      resources :room_types, only: %i[show new create], module: :accommodations
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
