class ApplicationController < ActionController::Base

	protect_from_forgery
	before_filter :login?, :except=> [ :intro ]

	public

	def intro
		redirect_to :home if user_signed_in?
	end

	def home
		user = current_user.authentications.find_by :provider=>:googleplus
logger.debug user.to_yaml
		sns = SNS::GooglePlus.new user
		sns.recent
	end

	private

	def login?
		redirect_to :root if !user_signed_in?
	end

end
