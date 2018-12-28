require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "invalid user submission" do 
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, params: { user: { name: "", 
																				 username: "$example.user", 
																				 email: "user@example", 
																				 password: "user",
																				 password_confirmation: "example" } }
		end
		assert_template 'users/new'
	end

	test "valid user submission" do 
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, params: { user: { name: "Example User", 
																				 username: "exampleuser", 
																				 email: "user@example.com", 
																				 password: "password",
																				 password_confirmation: "password" } }
		end
		follow_redirect!
		assert_template 'users/show'
	end
end