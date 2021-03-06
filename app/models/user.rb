class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token

	before_save :downcase_username, :downcase_email
	before_create :create_activation_digest

	validates :name, 			presence: true, length: { minimum: 4, maximum: 50 }
	validates :username,  presence: true, length: { minimum: 4, maximum: 15 }, 
												format: { with: /\A[a-zA-Z0-9_\.]+\z/ },
												uniqueness: { case_sensitive: false }
	validates :email, 		presence: true, length: {  maximum: 240 }, 
												format: { with: URI::MailTo::EMAIL_REGEXP },
												uniqueness: { case_sensitive: false }
	validates :password,	presence: true, length: { minimum: 8 }, allow_nil: true
	validates :time_zone, presence: true

	has_secure_password

	has_many :streams, 							 dependent: :destroy
	has_many :events,								 dependent: :destroy
	has_many :active_relationships,  class_name: "Relationship", 
																	 foreign_key: "follower_id", 
																	 dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship", 
																	 foreign_key: "followed_id", 
																	 dependent: :destroy

	has_many :following, 	 					 through: :active_relationships,  source: :followed
  has_many :followers, 	 					 through: :passive_relationships, source: :follower
  has_many :favorites,						 -> { where(relationships: { favorited: true }) }, through: :active_relationships,	 source: :followed

	mount_uploader :profile_pic, 			ProfilePicUploader
	mount_uploader :background_pic, 	BackgroundPicUploader

	validate :pic_size

	class << self
		# Returns the hash digest of the given string
		def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end

		# Returns a random token
		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	# Remembers a user in the database for persistent sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Returns true if the given token matches the digest
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Activates an account
	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
	end

	# Sends the activation email
	def send_activation_email
		UserMailer.user_activation(self).deliver_now
	end

	# Creates the reset password attributes
	def create_reset_digest
		self.reset_token = User.new_token
		update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)		
	end

	# Sends the password reset email
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	# Checks if password request is expired
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	# Defines post feed
	def schedule
		Stream.where("user_id = ?", id) + Event.where("user_id = ?", id)
	end

	def following_schedule
		following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		Stream.where("user_id IN (#{following_ids})", user_id: id) + Event.where("user_id IN (#{following_ids})", user_id: id)
	end

	def favorited_schedule
		favorited_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id && favorited = true"
		Stream.where("user_id IN (#{favorited_ids})", user_id: id) + Event.where("user_id IN (#{favorited_ids})", user_id: id)
	end

	# Follows a user
	def follow(other_user)
		active_relationships.create(followed_id: other_user.id)
	end

	# Unfollows a user
	def unfollow(other_user)
		active_relationships.find_by(followed_id: other_user.id).destroy
	end

	# Returns true if the current user is following the other user
	def following?(other_user)
		following.include?(other_user)
	end

	def favorite(other_user)
		active_relationships.find_by(followed_id: other_user.id).favorite
	end

	def unfavorite(other_user)
		active_relationships.find_by(followed_id: other_user.id).unfavorite
	end

	def favorited?(other_user)
		favorites.include?(other_user)
	end

	private
		# Converts username to lowercase for uniqueness
		def downcase_username
			self.username = username.downcase
		end

		# Converts email to lowercase for uniqueness
		def downcase_email
			self.email = email.downcase
		end

		# Creates and assigns activation token and digest
		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end

		def pic_size
			if profile_pic.size > 5.megabytes || background_pic.size > 5.megabytes
				errors.add(:user, "Picture Uploads Cannot Be Greater Than 5MB (づಠ╭╮ಠ)づ Please Try Again")
			end
		end
end