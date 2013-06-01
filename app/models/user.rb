class User < ActiveRecord::Base
	has_secure_password
	attr_accessible :name, :email, :password, :password_confirmation
	validates :name,  presence: true, length: { maximum: 50 }
	validates :email, presence: true
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token
	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
