class Message < ApplicationRecord
	attr_reader :user_tokens

	belongs_to :sender, class_name: 'User'
	has_many :recipients
	has_many :users, through: :recipients

	def user_tokens=(ids)
		self.user_ids = ids
	end
end
