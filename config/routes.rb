Rails.application.routes.draw do
  devise_for :users

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route (homepage)
  root "ads#index"

  # Nested resources for businesses and ads (if you want to create ads under a business)
  resources :businesses do
    resources :ads
  end

  # Ads with nested impressions and reviews for engagement features
  resources :ads, only: [:index, :show, :new, :create] do
    resources :impressions, only: [:create]
    resources :reviews, only: [:create, :index]
  end
end
