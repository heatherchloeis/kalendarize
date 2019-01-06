require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:geralt)
		log_in_as(@user)
	end

	test "profile page should include important information" do 
		get user_path(@user)
		assert_template 'users/show'
		assert_select 'title', full_title("#{@user.name} @#{@user.username}")
		assert_select 'p', text: "streamer"
		assert_match @user.streams.count.to_s, response.body
	end
end