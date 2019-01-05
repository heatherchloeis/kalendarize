require 'test_helper'

class StreamSubmissionTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:yennifer)
		@other_user = users(:cirilla)
		@stream = streams(:stream_two)
	end

	test "invalid stream submission" do
		log_in_as(@user)
		get root_path
		assert_select 'select#stream_day'
		assert_select 'input[type=time]', count: 2
		assert_no_difference 'Stream.count' do
			post streams_path, params: { stream: { day: '', start_time: '', end_time: '' } }
		end 
	end

	test "valid stream submission" do
		log_in_as(@user)
		get root_path
		assert_select 'select#stream_day'
		assert_select 'input[type=time]', count: 2
		assert_difference 'Stream.count', 1 do
			post streams_path, params: { stream: { day: '2019-01-12', start_time: '12:00:00', end_time: '16:00:00' } }
		end 
		assert_redirected_to root_url
	end

	test "valid stream deletion" do
		log_in_as(@user)
		get root_path
		assert_select 'div.dropright > div.dropdown-menu > a.dropdown-item'
		assert_difference 'Stream.count', -1 do
			delete stream_path(@stream)
		end
	end

	test "invalid stream deletion" do 
		log_in_as(@user)
		get user_path(@other_user)
		assert_select 'div.dropright > div.dropdown-menu > a.dropdown-item', count: 0
	end
end
