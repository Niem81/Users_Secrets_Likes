class User < ActiveRecord::Base
  	
	has_many :secrets
	has_many :likes, dependent: :destroy
	has_many :secrets_liked, through: :likes, source: :secret

  	has_secure_password

  	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :name, presence: true, length: {in: 2..20}
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	validates :password, length: { in: 6..20 }, on: :create, allow_nil: true

end
