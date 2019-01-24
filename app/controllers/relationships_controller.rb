class RelationshipsController < ApplicationController
	before_action :logged_in_user

  def create
  	@user = User.find(params[:followed_id])
  	if @user.streamer?
  		current_user.follow(@user)
  		respond_to do |format|
  			# Handle a Successful Follow
  			format.html { redirect_to @user }
  			format.js
  		end
  	else
  		# Handle an Unsuccessful Follow
  		flash[:danger] = "Oh Dear (づಠ╭╮ಠ)づ You Can't Follow Non-Streamers"
  		redirect_to @user 
  	end
  end

  def favorite
    @user = Relationship.find(params[:id]).followed
    current_user.favorite(@user)
    respond_to do |format|
      # Handle a Successful Unfollow
      format.html
      format.js
    end
  end

  def unfavorite
    @user = Relationship.find(params[:id]).followed
    current_user.unfavorite(@user)
    respond_to do |format|
      # Handle a Successful Unfollow
      format.html
      format.js
    end
  end

  def destroy
  	@user = Relationship.find(params[:id]).followed
  	current_user.unfollow(@user)
  	respond_to do |format|
  		# Handle a Successful Unfollow
  		format.html { redirect_to @user }
  		format.js
  	end
  end

  private
    def relationship_params
      params.require(:relationship).permit(:favorited)
    end
end
