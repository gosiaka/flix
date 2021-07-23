class FavoritesController < ApplicationController

  before_action :require_sign_in

  def create
    @movie = Movie.find(params[:movie_id])
    @movie.favorites.create!(user: current_user)
    redirect_to @movie   
  end
end
