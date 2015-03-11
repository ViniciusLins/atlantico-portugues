module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    # Was need use this check on cookies, 
    # because find by token are return the user with nil params
    if !@current_user && cookies[:remember_token]
      @current_user = User.find_by_remember_token(cookies[:remember_token])
    else
      @current_user
    end
  end
end
