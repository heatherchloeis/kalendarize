class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# Handle a successful user creation
			log_in @user
			flash[:success] = "Welcome to Kalendarize (ﾉ●ω●)ﾉ*:･ﾟ✧ Let's Get Started!!!"
			redirect_to @user
		else
			flash[:danger] = "Oh Dear (づ●︿●)づ Something Seems to Have Gone Wrong with Your Submission! Please Try Again"
			render 'new'
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			# Handle a successful user update
		else
			render 'edit'
		end
	end

	def edit
		@user = User.find(params[:id])
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