class ApplicationController < ActionController::Base

	protect_from_forgery
	before_filter :login?, :except=> [ :intro ]

	public

	def intro
		redirect_to :home if user_signed_in?
	end
	def home
	end

	private

	def login?
		redirect_to :root if !user_signed_in?
	end

end
