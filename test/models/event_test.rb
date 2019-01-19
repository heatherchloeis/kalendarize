require 'test_helper'

class EventTest < ActiveSupport::TestCase
	def setup
		@user = users(:yennifer)
		@other_user = users(:geralt)
		@event = @user.events.build(event_day: '2019-01-06', event_start: 'Wed, 09 Jan 2019 12:00:00 -0800', event_end: 'Wed, 09 Jan 2019 16:00:00 -0800', event_title: 'Example Event')
	end

	test "should be valid" do 
		assert @event.valid?
	end

	test "should not belong to a viewer" do
		@event.user_id = @other_user.id
		assert_not @event.valid?
	end

	test "user id, day, times, and title should be present" do 
		# Nil user id
		@event.user_id = nil
		assert_not @event.valid?
		# Nil day
		@event.event_day = nil
		assert_not @event.valid?
		# Nil start time
		@event.event_start = nil
		assert_not @event.valid?
		# Nil end time
		@event.event_end = nil
		assert_not @event.valid?
		# Nil title
		@event.event_title = nil
		assert_not @event.valid?
	end

	test "end time should occur after start time" do
		@event.event_start = 'Wed, 09 Jan 2019 16:00:00 -0800'
		@event.event_end = 'Wed, 09 Jan 2019 12:00:00 -0800'
		assert_not @event.valid?
	end

	# test "should not overlap" do
	# 	@event.save
	# 	@other_event = @user.events.build(event_day: '2019-01-06', event_start: 'Wed, 09 Jan 2019 10:00:00 -0800', event_end: 'Wed, 09 Jan 2019 14:00:00 -0800')
	# 	assert_not @other_event.valid?
	# end

	test "should be in chronological order" do
		assert_equal events(:event_one), Event.first
	end
end
