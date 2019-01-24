require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
	def setup
		@relationship = Relationship.new(follower_id: users(:geralt).id,
																		 followed_id: users(:yennifer).id)
	end

	test "should be valid" do
		assert @relationship.valid?
	end

	test "follower and followed should be present" do
		@relationship.follower_id = nil
		assert_not @relationship.valid?
		@relationship.followed_id = nil
		assert_not @relationship.valid?
	end

	test "follower cannot follow another follower" do
		@relationship.followed_id = users(:vesemir).id
		assert_not @relationship.valid?
	end

	test "followed cannot equal follower" do
		@relationship.follower_id = users(:yennifer).id
		assert_not @relationship.valid?
	end

	test "relationship can be favorited and unfavorited" do
		@relationship.favorited = true
		assert @relationship.valid?
		@relationship.favorited = false
		assert @relationship.valid?
	end
end
