module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
  #記録したURL(もしくはデフォルト)にリダイレクトする
  def redirect_back_or(default)
    redirect_to(session[:forwading_url] || default)
    session.delete(:forwading_url)
  end
  
  #アクセスしようとしたURLの保存
  def store_location
    session[:forwading_url] = request.original_url if request.get?
  end
end
