Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :profiles, only: [:index, :show, :new, :create, :edit, :update]
  resources :products , only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    resources :comments, only: [:create]    
  end

  resources :companies, only: [:index, :show]
  resources :comments, only: [] do 
    resources :answers , only: [:create]
  end
end
