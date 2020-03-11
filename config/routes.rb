Rails.application.routes.draw do
  resources :articles
  devise_for :users
  # Custom route for creating a new user - admin only
  devise_scope :user do
    post "/create_new_user" => "users/registrations#create"
  end

  resources :users

  post "/admin_create_new_user" => "users#create"

  root to: "welcome#index"
end
