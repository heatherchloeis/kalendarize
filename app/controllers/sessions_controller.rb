class SessionsController < ApplicationController
  def new
  	@title = "Log in"
  end

  def create
  	user = User.find_by(email: params[:session][:login].downcase) || User.find_by(username: params[:session][:login].downcase)
  	if user && user.authenticate(params[:session][:password])
   #    if user.activated?
    		log_in user
    		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    		redirect_to user
   #    else
   #      message = "Your account has not yet been activated."
   #      message += "Please check your email."
   #      flash[:warning] = message
   #      redirect_to root_url
   #    end
  	else
  		flash.now[:danger] = 'Invalid login combination'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
