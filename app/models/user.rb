class User < ApplicationRecord
	before_save { self.email = email.downcase }
	validates :username, presence: true, uniqueness: { case_sensitive: false},
						length: { minimum: 3, maximum: 25}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 
	validates :email, presence: true, uniqueness: { case_sensitive: false},
						format: {with: VALID_EMAIL_REGEX}
	has_secure_password
	has_many :send_messages, class_name: "Message", foreign_key: :sender_id
	has_many :recipients, -> { where("is_read = false").order("created_at desc") }
	has_many :messages, through: :recipients
end
