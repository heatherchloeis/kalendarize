require 'test_helper'

class StreamsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@stream = streams(:stream_one)
		@user = users(:yennifer)
	end

	test "should redirect create when not logged in" do 
		assert_no_difference 'Stream.count' do
			post streams_path, params: { stream: { day: '2019-01-07', start_time: '12:00:00', end_time: '16:00:00' } }
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do 
		assert_no_difference 'Stream.count' do
			delete stream_path(@stream)
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy for wrong stream" do
		log_in_as(@user)
		assert_no_difference 'Stream.count' do
			delete stream_path(@stream)
		end
		assert_redirected_to root_url
	end
end