class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    cookies[:test] = "TEST"
    logger.debug "session: #{cookies[:remember_token]}"

  end
  
  def index
  	
  end

  def create
  	@user = User.new(user_params)
  	logger.debug "Person attributes hash: #{@user.inspect}"
  	if @user.save
  		logger.debug "#{@user.inspect}"
      sign_in(@user)
      	redirect_to @user
    else
      	render 'new'
    end

  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def login
    @user = User.find_by email: params[:email]
    if @user and @user.authenticate params[:password]
      logger.debug "session: #{session.inspect}"
      sign_in(@user)
      redirect_to @user
    else
      @user = User.new
      render 'new'
    end
  end

  def logout
    sign_out
    redirect_to root_url
  end
end
