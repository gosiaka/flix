class GenresController < ApplicationController
before_action :require_admin, except: [:index, :show]

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @genre_movies = @genre.movies
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to @genre, notice: "Genre successfully created!"
    else
      render :new
    end   
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
