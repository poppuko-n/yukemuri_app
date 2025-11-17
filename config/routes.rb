Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: "admins/registrations", sessions: "admins/sessions" }
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  get "up" => "rails/health#show", as: :rails_health_check
end
