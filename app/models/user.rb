class User < ActiveRecord::Base
	has_many :user_languages, dependent: :destroy
	has_many :languages, through: :user_languages

	has_secure_password
	validates_confirmation_of :password
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :name, :alias, :street, :city, :state, presence: true
	validates :email,  uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	validates :password, length: {minimum: 6}, allow_nil: true

end
