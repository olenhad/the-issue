class Api::UsersController < ActionController::API
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  def create
  	@user = User.new(user_params)
  	logger.debug "Person attributes hash: #{@user.inspect}"
  	if @user.save
  		logger.debug "#{@user.inspect}"
      render json: {status: "success"}
    else
      render json: {status: "failure"}
    end

  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end