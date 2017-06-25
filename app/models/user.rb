class User < ApplicationRecord
	before_save { self.email = email.downcase }
	validates :username, presence: true, uniqueness: { case_sensitive: false},
						length: { minimum: 3, maximum: 25}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 
	validates :email, presence: true, uniqueness: { case_sensitive: false},
						format: {with: VALID_EMAIL_REGEX}
	has_secure_password

	mount_uploader :avatar, AvatarUploader

	#Facbook login
	def self.from_omniauth(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize
    unless user.id?
    	user.username = auth[:info][:name]
    	user.password = SecureRandom.base64(10)
    	user.save!
    end
    user
  end


	#Message
	has_many :send_messages, class_name: "Message", foreign_key: :sender_id
	has_many :recipients, -> { where("is_read = false").order("created_at desc") }
	has_many :messages, through: :recipients

	#Friendship
	has_many :friendships
	has_many :friends, through: :friendships

	def friend?(friend)
		Friendship.where(user_id: self.id, friend_id: friend.id).any?
	end

	def add_friend(friend)
		unless self == friend || self.friend?(friend)
			transaction do 
				Friendship.create(user_id: self.id, friend_id: friend.id)
				Friendship.create(user_id: friend.id, friend_id: self.id)
			end
		end
	end

	def remove_friend(friend)
		transaction do 
			Friendship.find_by(user_id: self.id, friend_id: friend.id).destroy
			Friendship.find_by(user_id: friend.id, friend_id: self.id).destroy
		end
	end

	
  
end
