Rails.application.routes.draw do

  root "movies#index"

  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  get "signup" => "users#new"
  
  resources :movies do
    resources :reviews, only: [:index, :new, :create, :destroy, :edit, :update]
  end
end
