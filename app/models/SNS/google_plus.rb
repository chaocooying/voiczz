class SNS::GooglePlus

	require "google/api_client"
	attr_accessor :api, :ref

	public

	def self.auth_url
		scopes = [
			"https://www.googleapis.com/auth/plus.me",
			"https://www.googleapis.com/auth/userinfo.email",
			"https://www.googleapis.com/auth/userinfo.profile"
		]
		return "/auth/google_oauth2?origin=googleplus&scope=#{scopes.join '+'}"
	end
	def self.parse data
		return {
			:provider    => data[:provider],
			:uid         => data[:uid],
			:email       => data[:info][:email],
			:name        => data[:info][:name],
			:nickname    => data[:info][:nickname],
			:pic         => data[:info][:image],
			:url         => data[:extra][:raw_info][:link],
			:credentials => {
				:token         => data[:credentials][:token],
				:refresh_token => data[:credentials][:refresh_token],
				:expires_in    => data[:credentials][:expires_at]
			}
		}
	end
	def initialize user
		auth = YAML.load_file "#{Rails.root}/config/omniauth.yml"
		@api = Google::APIClient.new
 		@api.authorization.client_id = auth[:google][:key]
 		@api.authorization.client_secret = auth[:google][:secret]
 		@api.authorization.scope = auth[:google][:scope]
 		@api.authorization.access_token = user.credentials["token"]
 		@api.authorization.refresh_token = user.credentials["refresh_token"]
 		@api.authorization.expires_in = user.credentials["expires_in"]
		@ref = @api.discovered_api "plus"
	end
	def recent params = {}
		params[:scope] = "public" if params[:scope].nil?
		result = @api.execute @ref.activities.list, :userId=>"me",:collection=>params[:scope]
		return result.body
	end

	private

	# CASE: when using google API key
	# def authorize config
	# 	file = SNS.getFile config[:key]
	# 	key = Google::APIClient::PKCS12.load_key file, config[:password]
	# 	asserter = Google::APIClient::JWTAsserter.new config[:id], config[:url], key
	# 	return asserter.authorize
	# end

end
