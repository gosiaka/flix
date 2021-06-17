Rails.application.routes.draw do
  get "movies" => "movies#index"
  get "movies/:id" => "movies#show", as: "show_movie"
end
