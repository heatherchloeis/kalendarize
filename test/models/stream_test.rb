require 'test_helper'

class StreamTest < ActiveSupport::TestCase
	def setup
		@user = users(:yennifer)
		@other_user = users(:geralt)
		@stream = @user.streams.build(day: '2019-01-06', start_time: '12:00:00', end_time: '16:00:00')
	end

	test "should be valid" do 
		assert @stream.valid?
	end

	test "should not belong to a viewer" do
		@stream.user_id = @other_user.id
		assert_not @stream.valid?
	end

	test "user id, day, and times should be present" do 
		# Nil user id
		@stream.user_id = nil
		assert_not @stream.valid?
		# Nil day
		@stream.day = nil
		assert_not @stream.valid?
		# Nil start time
		@stream.start_time = nil
		assert_not @stream.valid?
		@stream.end_time = nil
		assert_not @stream.valid?
	end

	test "end time should occur after start time" do
		@stream.start_time = '16:00:00'
		@stream.end_time = '12:00:00'
		assert_not @stream.valid?
	end

	test "should not overlap" do
		@stream.save
		@other_stream = @user.streams.build(day: '2019-01-06', start_time: '10:00:00', end_time: '14:00:00')
		assert_not @other_stream.valid?
	end

	test "should be in chronological order" do
		assert_equal streams(:stream_one), Stream.first
	end
end
