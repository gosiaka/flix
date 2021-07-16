class ApplicationController < ActionController::Base

private

  def require_sign_in
    unless current_user
      session[:intendent_page] = request.url
      redirect_to signin_path, alert: "Please sign in"
    end
  end

  def current_user
    # dodajemy zmienną @current_user, żeby app nie musiała za każdym razem szukać user_id.zmienna zostaje zapisana i jest używana podczas jednego zapytania
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

end
