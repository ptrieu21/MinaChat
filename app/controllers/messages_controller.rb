class MessagesController < ApplicationController
	before_action :require_user
	before_action :find_user
	before_action :set_message, only: [:show]

	def index
		@messages = @user.send_messages
	end

	def inbox
		@messages = @user.messages
	end

	def new
		@message = Message.new
		@users = User.all
	end

	def create
		@message = @user.send_messages.build(message_params)
		if @message.save
			flash[:success] = "Message Sent!"
			redirect_to messages_path
		else
			flash[:notice] = "Oops!"
			render 'new'
		end
	end

	def show
	end

	private
		def message_params
			params.require(:message).permit(:body, :sender_id, user_tokens: [])
		end
		def set_message
			@message = Message.find(params[:id])
			@recipient = Recipient.find_by(message: @message, user: @user)
			if @recipient.is_read
				flash[:danger] = "This message have already been read!"
				redirect_to inbox_path
			end

		end

		def find_user
			@user = User.find(current_user)
		end
end
