Rails.application.routes.draw do

  root "movies#index"

  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  get "signup" => "users#new"

  resource :session, only: [:create, :destroy] # singular resource
  get "signin" => "sessions#new" # custom route for Signup Page

  
  resources :movies do
    resources :reviews, only: [:index, :new, :create, :destroy, :edit, :update]
    resources :favorites, only: [:create, :destroy]
  end
end
