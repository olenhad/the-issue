class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def index
  	
  end

  def create
  	@user = User.new(user_params)
  	logger.debug "Person attributes hash: #{@user.inspect}"
  	if @user.save
  		logger.debug "#{@user.inspect}"
      	redirect_to @user
    else
      	render 'new'
    end

  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
