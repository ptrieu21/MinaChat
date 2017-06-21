class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Welcome to MinaChat #{@user.username}"
			redirect_to users_path
		else
			render 'new'
		end
	end

	def edit

	end

	def update

	end

	def destroy
		@user = User.find[params[:id]]
		@user.destroy
		flash[:destroy] = "This user have been deleted"
		redirect_to users_path
	end


	private
		def user_params
			params.require(:user).permit(:username, :email, :password)
		end

		def set_user
			@user = User.find(params[:id])
		end

		def require_same_user

		end
end
