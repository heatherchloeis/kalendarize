class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def new
		@title = "Sign up"
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to Kalendarize (ﾉ●ω●)ﾉ*:･ﾟ✧ Let's Get Started!!!"
			redirect_to @user
		else
			flash[:danger] = "Oh Dear (づ●︿●)づ Something Seems to Have Gone Wrong with Your Submission! Please Try Again"
			render 'new'
		end
	end

	def update
	end

	def edit
	end

	def destroy
	end

	private
		def user_params
			params.require(:user).permit(:name,
																	 :username,
																	 :email,
																	 :password,
																	 :password_confirmation)
		end
end