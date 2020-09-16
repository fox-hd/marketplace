Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :profiles, only: [:index, :show, :new, :create, :edit, :update]
  resources :products , only: [:index, :show, :new, :create, :edit, :update] do
    resources :orders, only: [:show,:new, :create]
    get 'search', on: :collection
    resources :comments, only: [:create]
    post 'enable', on: :member
    post 'disable', on: :member
    get 'status', on: :member
  end
  get 'my_products', to: 'products#my_products'

  resources :orders, only:[:index] do
    resources :chats, only: [:create]
    post 'accept', on: :member
    post 'decline', on: :member
  end

  resources :companies, only: [:index, :show]
  resources :comments, only: [] do 
    resources :answers , only: [:create]
  end
end
