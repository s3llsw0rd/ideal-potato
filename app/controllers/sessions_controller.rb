class SessionsController < ApplicationController
  def new
  	@user = User.new
  	@session = User.new
  end

  def create
	@session = User.find_by( email: session_params['email'] )
	if @session
		if !@session.authenticate( session_params['password'] )
			flash[:alert] = "Invalid Password"
  			redirect_to main_path
  		else
  			session[:user_id] = @session.id
  			redirect_to shoes_path
  		end
  	else
  		flash[:alert] = "Invalid Email"
  		redirect_to main_path
  	end
  end

  def destroy
  	session.clear
  	redirect_to main_path
  end

  private
  	def session_params
  		params.require(:user).permit(:email, :password)
  	end

end
