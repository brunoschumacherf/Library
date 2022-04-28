module ApiHelper
  def sign_in(user)
    session[:user_email] = user.email
  end

  def current_user
    @current_user ||= User.find_by(email: session[:user_email])
  end

  def signOut
    session.delete(:user_email)
    @current_user = nil
  end

end