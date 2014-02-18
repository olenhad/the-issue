module UsersHelper
	def sign_in(user)
      logger.debug "Signing in #{user}"
	    remember_token = User.new_remember_token
	    cookies.permanent[:remember_token] = remember_token
	    user.update_attribute(:remember_token, User.encrypt(remember_token))
	    self.current_user = user
	end
    
  def current_user=(user)
    	@current_user = user
 	end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token)) if current_user
    cookies.delete(:remember_token)
    self.current_user = nil
    session.delete(:user_id)
  end

  def logged_in?
    !fb_user.nil? or signed_in?
  end
  
  def fb_user
    @fb_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_user
    if fb_user then
      @logged_user = fb_user
    elsif current_user then
      @logged_user = current_user
    else
    end
  end

end
