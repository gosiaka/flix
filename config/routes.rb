Rails.application.routes.draw do

  root "movies#index"

  resources :users
  
  resources :movies do
    resources :reviews, only: [:index, :new, :create, :destroy, :edit, :update]
  end
end
