class GenresController < ApplicationController
before_action :require_admin, except: [:index, :show]
before_action :set_slug, only: [:show, :edit, :update, :destroy]

  def index
    @genres = Genre.all
  end

  def show
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

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: "Genre successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @genre.destroy
    redirect_to genres_path, alert: "Genre successfully deleted!"
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_slug
    @genre = Genre.find_by!(slug: params[:id])
  end
end
