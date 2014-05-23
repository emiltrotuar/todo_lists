class User < ActiveRecord::Base
	has_secure_password

	has_many :projects, dependent: :destroy
	has_many :tasks, through: :projects
	has_many :notes

	validates :name,  presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
