class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:login].downcase) || User.find_by(username: params[:session][:login].downcase)
  	if user && user.authenticate(params[:session][:password])
      if user.activated?
    		log_in user
    		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    		redirect_back_or user
      else
        message = "REEE (づಠ╭╮ಠ)づ Your Account Has Not Yet Been Activated!"
        message += "Check Your Email!"
        flash[:warning] = message
        redirect_to root_url
      end
  	else
  		flash.now[:danger] = 'OH NO o(╥﹏╥)o Invalid Login Combination! Please Try Again!'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end