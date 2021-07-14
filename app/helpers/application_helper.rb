module ApplicationHelper

  def current_user
    # dodajemy zmienną @current_user, żeby app nie musiała za każdym razem szukać user_id.zmienna zostaje zapisana i jest używana podczas jednego zapytania
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
