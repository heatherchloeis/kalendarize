class User < ApplicationRecord
	attr_accessor :remember_token

	before_save { self.username = username.downcase }
	before_save { self.email = email.downcase }

	validates :name, 			presence: true, length: { minimum: 4, maximum: 50 }
	validates :username,  presence: true, length: { minimum: 4, maximum: 15 }, 
												format: { with: /\A[a-zA-Z0-9_\.]+\z/ },
												uniqueness: { case_sensitive: false }
	validates :email, 		presence: true, length: {  maximum: 240 }, 
												format: { with: URI::MailTo::EMAIL_REGEXP },
												uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password,	presence: true, length: { minimum: 8 }

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

	# Returns true if the given token matches the digest
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end
end