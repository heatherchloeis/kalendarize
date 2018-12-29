require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:geralt)
	end

	test "invalid edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params: { user: { name: "",
																							username: "geralt@rivia",
																							email: "",
																							password: "pass",
																							password_confirmation: "word" } }
		assert_template 'users/edit'
	end

	test "valid edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		name = "Geralt"
		username = "bigpapageralt"
		patch user_path(@user), params: { user: { name: name,
																							username: username,
																							password: "",
																							password_confirmation: "" } }
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal username, @user.username
	end

	test "should redirect edit when not logged in" do
		get edit_user_path(@user)
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect update when not logged in" do
		patch user_path(@user), params: { user: { name: @user.name,
																							username: @user.username } }
		assert_not flash.empty?
		assert_redirected_to login_url
	end
end