require 'test_helper'

class StreamTest < ActiveSupport::TestCase
	def setup
		@user = users(:yennifer)
		@other_user = users(:geralt)
		@stream = @user.streams.build(stream_day: '2019-01-06', stream_start: 'Wed, 09 Jan 2019 12:00:00 -0800', stream_end: 'Wed, 09 Jan 2019 16:00:00 -0800')
	end

	test "should be valid" do 
		assert @stream.valid?
	end

	test "should not belong to a viewer" do
		@stream.user_id = @other_user.id
		assert_not @stream.valid?
	end

	test "user id, day, times, and time-zones should be present" do 
		# Nil user id
		@stream.user_id = nil
		assert_not @stream.valid?
		# Nil day
		@stream.stream_day = nil
		assert_not @stream.valid?
		# Nil start time
		@stream.stream_start = nil
		assert_not @stream.valid?
		# Nil end time
		@stream.stream_end = nil
		assert_not @stream.valid?
	end

	test "end time should occur after start time" do
		@stream.stream_start = 'Wed, 09 Jan 2019 16:00:00 -0800'
		@stream.stream_end = 'Wed, 09 Jan 2019 12:00:00 -0800'
		assert_not @stream.valid?
	end

	test "should not overlap" do
		@stream.save
		@other_stream = @user.streams.build(stream_day: '2019-01-06', stream_start: 'Wed, 09 Jan 2019 10:00:00 -0800', stream_end: 'Wed, 09 Jan 2019 14:00:00 -0800')
		assert_not @other_stream.valid?
	end

	test "should be in chronological order" do
		assert_equal streams(:stream_one), Stream.first
	end
end
