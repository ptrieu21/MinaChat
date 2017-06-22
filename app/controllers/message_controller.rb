class MessageController < ApplicationController
	before_action :require_user
	before_action :set_message, only: [show]

	def inbox
		@messages = current_user.received_messages.where(is_read: false).order(created_at: :desc)
	end

	def sent
		@messages = current_user.sent_messages.order(created_at: :desc)
	end

	def new

	end

	def create

	end

	private
		def set_message
			@message = Message.find(params[:id])
end
