class GenresController < ApplicationController
before_action :require_admin, except: [:index, :show]

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @genre_movies = @genre.movies
  end
end