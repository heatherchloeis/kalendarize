class Relationship < ApplicationRecord
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"

	validates :follower_id,	presence: true
	validates :followed_id,	presence: true

	validate  :followed_is_streamer, :followed_is_not_follower

	def favorite
		update_attribute(:favorited, true)
	end

	def unfavorite
		update_attribute(:favorited, false)
	end

	private
		def followed_is_streamer
			@streamer = User.where(["id = ? and streamer = ?", followed_id, true])
			if @streamer.nil? || @streamer.blank?
				errors.add(:followed_id, "Oh Dear (づಠ╭╮ಠ)づ You Can't Follow Non-Streamers")
			end
		end

		def followed_is_not_follower
			if followed_id == follower_id
				errors.add(:followed_id, "Wow! You Must Really Think You're Something (づಠ╭╮ಠ)づ You Can't Follow Yourself")				
			end
		end
end
