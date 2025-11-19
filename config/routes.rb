Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: "admins/registrations", sessions: "admins/sessions" }
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  root 'accommodations#index'

  resources :accommodations, only: %i[index]

  namespace :users do
    root 'accommodations#index'
    resources :accommodations, only: %i[index show] do
      resources :room_types, only: %i[show], module: :accommodations do
        resources :reservations, only: %i[new create], module: :room_types do
          collection do
            match :confirm, via: %i[get post]
          end
        end
      end
    end
    resources :reservations, only: %i[index show update]
  end

  namespace :admins do
    root 'accommodations#index'
    resources :accommodations, only: %i[index show new create edit update destroy] do
      resources :room_types, only: %i[show new create edit update destroy], module: :accommodations do
        resources :room_inventories, only: %i[new create edit update], module: :room_types
      end
    end
    resources :users, only: %i[index show destroy]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
