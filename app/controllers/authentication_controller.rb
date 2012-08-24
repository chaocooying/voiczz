class AuthenticationController < ApplicationController

	before_filter :login?, :only=> [ :index ]

	public

	def index
		if current_user.authentications.empty?
			flash[:message] = t "msg.authentication.empty"
			render "authentication/empty"
		end
	end

	def create
		data = Authentication.parse request.env["omniauth.auth"]
 		existing_users = Authentication.all :provider=>data[:provider], :uid=>data[:uid]
 		## CASE: user has logged in, we will check if he connects a new SNS service entity
		if user_signed_in?
			logger.debug "***** #{existing_users}"
			logger.debug "***** #{!existing_users}"
			logger.debug "***** #{existing_users.empty?}"
			logger.debug "***** #{existing_users.size}"
			current_user.authentications.create data if existing_users.empty?
			redirect_to :action=>:index
 		## CASE: user has registered with this SNS service entity before
		elsif !existing_users.empty?
			user = find_which existing_users
			sign_in user
			redirect_to :home, :notice => (t "login.back", :user=>data[:name])
 		## CASE: new registration
		else
			user = User.new :email=>data[:email], :provider=>data[:provider], :uid=>data[:uid], :pic=>data[:pic]
			user.authentications.build data
			user.save :validate=>false
			sign_in user
			redirect_to :home, :notice => (t "login.new", :user=>data[:name])
		end
	end

	private

	def find_which accounts
		accounts.each do |account|
			return account.user if account.provider == account.user.provider && account.email == account.user.email
		end
		return accounts.first.user
	end

end
