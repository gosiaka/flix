class MoviesController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
    @review = @movie.reviews.new
    @fans = @movie.fans
    @genres = @movie.genres
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update    
    @movie = Movie.find(params[:id])
    
    if @movie.update(movie_params)
      flash[:notice] = "Movie successfully updated!"
      redirect_to movie_path    
    else
      render :edit
    end   
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end   
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, alert: "Movie successfully deleted!"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
  end
end
