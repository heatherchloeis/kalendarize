class User < ApplicationRecord
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
end