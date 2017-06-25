class FriendshipsController < ApplicationController
	before_action :require_user
	before_action :set_friend, except: [:index]
	before_action :set_friendship, only: [:delete]

	def index
		@users = current_user.friends

	end

	def create
		if current_user.add_friend(@friend)
			flash[:success] = "Add Friend sucess"
			redirect_to request.path
		else

		end
	end

	def destroy
		if current_user.remove_friend(@friend)
			flash[:success] = "Unfriend success"
			redirect_to request.path
		else

		end
	end

	private
		def set_friend
			@friend = User.find(params[:friend_id])
		end

		def set_friendship
		end
end
