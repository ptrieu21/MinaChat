class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_logout, only: [:new]

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
			flash[:success] = "Your account have been created, please login to continute"
			redirect_to login_path
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
			if current_user != @user
				flash[:error] = "You can only edit your own account"
				redirect_to root_path
			end
		end

		def require_logout
			if logged_in?
				flash[:notice] = "You must logout before creating new account"
				redirect_to inbox_path
			end
		end
end
