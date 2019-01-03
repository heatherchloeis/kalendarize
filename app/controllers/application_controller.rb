class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

	private
		# Confirms logged-in user
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in (ﾉಠ_ಠ)ﾉ 彡 ┻━┻"
				redirect_to login_url
			end
		end

    # Confirms streamer user
    def streamer_user
    	redirect_to(root_url) unless current_user.streamer?
    end
end
