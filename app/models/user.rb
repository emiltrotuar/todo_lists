class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	has_many :projects, dependent: :destroy
	validates :name,  presence: true, length: { maximum: 50 }
	validates :email, presence: true
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
