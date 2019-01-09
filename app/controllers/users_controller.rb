class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index,
																				:edit,
                                        :update, 
                                        :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,			only: :destroy
  # before_action :streamer_user,		only: [:followers]

  def index
  	@users = User.where(activated: true)
  end

	def show
		@user = User.find(params[:id])
		redirect_to root_url and return unless @user.activated?
		@streams = @user.streams
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# Handle a successful user creation
			@user.send_activation_email
			flash[:success] = "Welcome to Kalendarize (ﾉ●ω●)ﾉ*:･ﾟ✧ Please Check Your Email to Activate Your Account!!!"
			redirect_to login_url
		else
			flash[:danger] = "Oh Dear (づಠ╭╮ಠ)づ Something Seems to Have Gone Wrong with Your Submission! Please Try Again"
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			# Handle a successful user update
			flash[:success] = "Your Profile Has Been Successfully Updated (ﾉ●ω●)ﾉ*:･ﾟ✧"
			redirect_to @user
		else
			# Handle an unsuccessful user update
			flash[:danger] = "Oh Dear (づಠ╭╮ಠ)づ Something Seems to Have Gone Wrong! Please Try Again"
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "The User Has Been Successfully Deleted o(╥﹏╥)o"
		redirect_to users_url
	end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'follow'
  end

	private
		def user_params
			params.require(:user).permit(:name,
																	 :username,
																	 :email,
																	 :password,
																	 :password_confirmation,
																	 :streamer,
																	 :profile_pic,
																	 :background_pic)
		end

		# Confirms correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms admin user
    def admin_user
    	redirect_to(root_url) unless current_user.admin?
    end
end