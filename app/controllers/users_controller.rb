class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_sign_in, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"      
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to  movies_path, alert: "Account successfully deleted"
  end

  private

  def require_correct_user
    # zadziała tylko przy zmianie usera (do edycji itp) w adresie URL (już nie wyświetla nam buttonów)
    redirect_to movies_path, alert: "You're not a #{@user.username}" unless current_user?(@user)
  end

  def user_params
    params.required(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by!(slug: params[:id])
  end
end
