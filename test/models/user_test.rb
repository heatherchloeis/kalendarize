require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "Example User",
										 username: "exampleuser",
										 email: "user@example.com",
										 password: "password",
										 password_confirmation: "password")
	end

	# User name, username, email, and password testing suite

	test "should be valid" do
		assert @user.valid? 
	end 

	test "name, username, email, password should be present" do 
		@user.name = "   "
		@user.username = "   "
		@user.email = "   "
		@user.password = "   "
		assert_not @user.valid?
	end

	test "name, username, and password should have min characters" do
		@user.name = "a" * 3
		@user.username = "a" * 3
		@user.password = "a" * 7
		assert_not @user.valid?		
	end

	test "name, username, and email should have max characters" do
		@user.name = "a" * 51
		@user.username = "a" * 16
		@user.email = "a" * 241 + "example.com"
		assert_not @user.valid?
	end

	test "name, username, and email should contain valid characters" do
		valid_names = %w[Example\ User ExampleUser Ex.\ AmPlE\ uSeR]
		valid_names.each do |valid_name|
			@user.name = valid_name
			assert @user.valid?
		end
		valid_usernames = %w[exampleuser example_user exampleuser1 ExAmPlEuSeR_1]
		valid_usernames.each do |valid_username|
			@user.username = valid_username
			assert @user.valid?
		end
		valid_emails = %w[user@example.com example_USER@example.com example+user1@example.co ex.ample-user@example.user.com]
		valid_emails.each do |valid_email|
			@user.email = valid_email
			assert @user.valid?
		end
	end

	test "username and email should not contain invalid characters" do
		invalid_usernames = %w[example+user example-user $example_user! @#$%^&*()]
		invalid_usernames.each do |invalid_username|
			@user.username = invalid_username
			assert_not @user.valid?
		end
		invalid_emails = %w[user@example,com $user()example.co user_at_example user@ex+ample.com user@ex_ample.com user@example.]
		invalid_emails.each do |invalid_email|
			@user.email = invalid_email
			assert_not @user.valid?
		end
	end

	test "username and email should be unique" do
		# Check duplicate username
		duplicate_user = @user.dup
		duplicate_user.username = @user.username.upcase
		@user.save
		assert_not duplicate_user.valid?
		mixed_case_username = "ExAmPlEuSeR"
		@user.username = mixed_case_username
		@user.save
		assert_equal mixed_case_username.downcase, @user.reload.username
		# Check duplicate email
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
		mixed_case_email = "UsEr@ExAmPlE.com"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end

	# User login/logout testing suite

	test "authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?('')
	end
end