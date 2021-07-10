class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:email_or_username]) || User.find_by(username: params[:email_or_username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Nice to see you again #{user.username}"
    else
      flash.now[:alert] = "Invalid email/password combitanion!"
      render :new
    end
  end

  def destroy
  end


end
