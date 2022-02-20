# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth/v1/users'

  namespace :admin, defaults: { format: :json } do
    namespace :v1 do
      get 'home' => 'home#index'
      resources :categories
      resources :products
      resources :users
      resources :orders
      resources :tables
      resources :order_items
      resources :bills
    end
  end


namespace :storefront, defaults: { format: :json } do
    namespace :v1 do
      get "home" => "home#index"
      resources :products, only: [:index, :show]
      resources :categories, only: :index
      resources :tables, only: :index
      resources :orders, only: [:index, :show]
    end
  end
end