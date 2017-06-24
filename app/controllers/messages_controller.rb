class MessagesController < ApplicationController
	before_action :require_user
	before_action :set_user
	def index
		@messages = @user.send_messages
	end

	def inbox
		@messages = @user.messages
	end

	def new
		@message = Message.new
		@users = @user.friends
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
		@message = Message.find(params[:id])
		@recipient = Recipient.find_by(message: @message, user: @user)
		if @recipient.nil?
			flash[:danger] = "You cannot read this message"
			redirect_to inbox_path
		else
			if @recipient.is_read
				flash[:danger] = "This message have already been read!"
				redirect_to inbox_path
			else
				@recipient.update_attribute :is_read, true
				flash[:success] = "You have read this message!"
			end
		end 
	end

	private
		def message_params
			params.require(:message).permit(:body, :sender_id, user_tokens: [])
		end
		

		def set_user
			@user = User.find(current_user)
		end
end
