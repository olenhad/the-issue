class Api::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  def create
  	@user = User.new(user_params)
    if @user.auth_type == 'facebook'
      @user.password = SecureRandom.uuid
      @user.password_confirmation = @user.password
      @user.password_digest = 'secret_digest'
    else
      render json: {status: "failure"}
    end
    
  	logger.debug "Person attributes hash: #{@user.inspect}"
    logger.debug @user.password
  	if @user.save
  		logger.debug "#{@user.inspect}"
      render json: {status: "success", user: @user}
    else
      render json: {status: "failure", errors: @user.errors}
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :auth_type)
  end

  def search
    if params[:email]
      @user = User.find_by(email: params[:email])
      render json: @user
    else
      render json: {status: "failure", errors: ["Provide params"]}
    end
  end

end