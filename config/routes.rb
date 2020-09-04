Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :profiles, only: [:index, :show, :new, :create, :edit, :update]
  resources :products , only: [:index, :show, :new, :create, :edit, :update]
  resources :companies, only: [:index, :show]
end
