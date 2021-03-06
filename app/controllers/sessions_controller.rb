class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		session[:user_id] = user.id
  		flash[:success] = "You have successfully logged in"
  		redirect_to inbox_path
  	else
  		flash.now[:error] = "There was something wrong with your login information"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id] = nil
  	flash[:success] = "You have successfully logged out"
  	redirect_to root_path
  end

  def callback
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to inbox_path
    else
      flash.now[:error] = "There was something wrong with your login information"
      render 'new'
    end
  end

  
end
