class FriendshipsController < ApplicationController
	before_action :require_user
	before_action :set_friend, except: [:index]

	def index
		@friends = current_user.friends

	end

	def create
		if current_user.add_friend(@friend)
			flash[:susscess] = "Friend have been added!"
			redirect_to friendships_path
		else

		end
	end

	private
		def set_friend
			@friend = User.find(params[:friend_id])
		end
end
