Rails.application.routes.draw do

  root "movies#index"

  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  get "signup" => "users#new"

  resource :session, only: [:new, :create, :destroy] # singular resource
  
  resources :movies do
    resources :reviews, only: [:index, :new, :create, :destroy, :edit, :update]
  end
end
