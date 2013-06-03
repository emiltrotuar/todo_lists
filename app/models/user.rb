class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	has_many :tasks, dependent: :destroy
	validates :name,  presence: true, length: { maximum: 50 }
	validates :email, presence: true
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	def feed
      # This is preliminary. See "Following users" for the full implementation.
      Task.where("user_id = ?", id)
    end
    
	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
