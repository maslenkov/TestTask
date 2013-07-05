module SessionsHelper
  def sign_in user
    cookies.permanent[:user_id] = user.id
  end

  #def curent_user=(user)
  #  @curent_user = user
  #end

  def current_user
    @current_user ||= User.find(cookies[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    @current_user = nil
    cookies.delete(:user_id)
  end
end
