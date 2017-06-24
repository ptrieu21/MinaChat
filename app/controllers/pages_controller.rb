class PagesController < ApplicationController
	def home
		redirect_to inbox_path if logged_in?
	end
end
